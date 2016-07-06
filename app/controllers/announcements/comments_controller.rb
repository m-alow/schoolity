class Announcements::CommentsController < ApplicationController
  # POST /announcements/1/comments
  def create
    @announcement = Announcement.find params[:announcement_id]
    authorize @announcement, :show?

    comment = @announcement.comments.build(
      user: current_user,
      role: user_role,
      body: params[:comment][:body])

    respond_to do |format|
      if comment.save
        format.html { redirect_to @announcement, notice: 'Comment was successfully added.' }
        format.js { render 'comments/create', locals: { comment: comment } }
      else
        format.html { redirect_to @announcement, notice: 'Comment was not added.' }
        format.js { render nothing: true }
      end
    end
  end

  private

  def user_role
    send @announcement.announceable_type.underscore.+('_user_role')
  end

  def school_user_role
    school = @announcement.announceable
    if current_user.owns? school
      'School Owner'
    elsif current_user.administrates? school
      'School Admin'
    elsif current_user.teaches_in_school? school
      'Teacher'
    elsif current_user.follows_student_in_school? school
      'Parent'
    end
  end

  def school_class_user_role
    school_class = @announcement.announceable
    if current_user.owns? school_class.school
      'School Owner'
    elsif current_user.administrates? school_class.school
      'School Admin'
    elsif current_user.teaches_in_school_class? school_class
      'Teacher'
    elsif current_user.follows_student_in_school_class? school_class
      'Parent'
    end
  end

  def classroom_user_role
    classroom = @announcement.announceable
    if current_user.owns? classroom.school
      'School Owner'
    elsif current_user.administrates? classroom.school
      'School Admin'
    elsif current_user.teaches_in_classroom? classroom
      'Teacher'
    elsif current_user.follows_student_in_classroom? classroom
      'Parent'
    end
  end
end
