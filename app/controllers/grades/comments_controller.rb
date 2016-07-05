class Grades::CommentsController < ApplicationController
  # POST /grades/1/comments
  def create
    @grade = Grade.find params[:grade_id]
    comment = @grade.comments.build(
      user: current_user,
      role: user_role,
      body: params[:comment][:body])

    authorize comment

    respond_to do |format|
      if comment.save
        format.html { redirect_to @grade, notice: 'Comment was successfully added.' }
        format.js
      else
        format.html { render 'grades/show' }
        format.js { render nothing: true }
      end
    end

  end

  private

  def user_role
    if current_user.teaches_subject_in_classroom? @grade.exam.subject, @grade.exam.classroom
      'Teacher'
    elsif current_user.administrates? @grade.exam.classroom.school
      'School Admin'
    elsif current_user.owns? @grade.exam.classroom.school
      'School Owner'
    elsif current_user.follows? @grade.student
      'Parent'
    end
  end
end
