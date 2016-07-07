class Lessons::CommentsController < ApplicationController
  # POST /lessons/1/comments
  def create
    @lesson = Lesson.find params[:lesson_id]
    comment = @lesson.comments.build(
      user: current_user,
      role: user_role,
      body: params[:comment][:body])

    authorize @lesson, :show?

    respond_to do |format|
      if comment.save
        Notifier::Update
          .new(Scope::Exclude.new(
                Scope::Classroom::Followers.new(@lesson.day.classroom),
                current_user))
          .call @lesson

        format.html { redirect_to @lesson, notice: 'Comment was successfully added.' }
        format.js { render 'comments/create', locals: { comment: comment } }
      else
        format.html { redirect_to @lesson, notice: 'Comment was not added.' }
        format.js { render nothing: true }
      end
    end
  end

  private

  def user_role
    school = @lesson.day.classroom.school
    if current_user.owns? school
      'School Owner'
    elsif current_user.administrates? school
      'School Admin'
    elsif current_user.teaches_subject_in_classroom? @lesson.subject, @lesson.day.classroom
      'Teacher'
    elsif current_user.follows_student_in_classroom? @lesson.day.classroom
      'Parent'
    end
  end
end
