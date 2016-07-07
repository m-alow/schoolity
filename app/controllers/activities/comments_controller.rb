class Activities::CommentsController < ApplicationController
  # POST /activities/1/comments
  def create
    @activity = Activity.find params[:activity_id]
    comment = @activity.comments.build(
      user: current_user,
      role: user_role,
      body: params[:comment][:body])

    authorize @activity, :show?

    respond_to do |format|
      if comment.save
        Notifier::Update
          .new(Scope::Exclude.new(
                Scope::Student::Followers.new(@activity.student),
                current_user))
          .call @activity

        format.html { redirect_to @activity, notice: 'Comment was successfully added.' }
        format.js { render 'comments/create', locals: { comment: comment } }
      else
        format.html { redirect_to @activity, notice: 'Comment was not added.' }
        format.js { render nothing: true }
      end
    end
  end

  private

  def user_role
    if current_user.owns? @activity.student.school
      'School Owner'
    elsif current_user.administrates? @activity.student.school
      'School Admin'
    elsif current_user.teaches_subject_in_classroom? @activity.lesson.subject, @activity.lesson.day.classroom
      'Teacher'
    elsif current_user.follows? @activity.student
      'Parent'
    end
  end
end
