module ApplicationHelper
  def flash_class(level)
    type = ''
    type = 'info' if level == :notice
    type = 'success' if level == :success
    type = 'danger' if level == :alert || level == :error
    "alert alert-#{type}"
  end

  def lesson_content_layout lesson
    "lessons/#{lesson.content_type}_content"
  end

  def lesson_content_fields_layout lesson
    "lessons/#{lesson.content_type}_content_fields"
  end

  def day_content_layout day
    "days/#{day.content_type}_content"
  end

  def day_content_fields_layout day
    "days/#{day.content_type}_content_fields"
  end

  def activity_content_layout activity
    "activities/#{activity.content_type}_content"
  end

  def activity_content_fields_layout activity
    "activities/#{activity.content_type}_content_fields"
  end

  def admin?
    current_user.admin?
  end

  def owner? school
    current_user.owns? school
  end

  def administrator? school
    current_user.administrates? school
  end

  def owner_or_administrator? school
    owner?(school) || administrator?(school)
  end

  def classroom_teacher? classroom
    current_user.teaches_in_classroom? classroom
  end

  def classroom_staff? classroom
    owner_or_administrator?(classroom.school) || classroom_teacher?(classroom)
  end

  def subject_teacher? subject, classroom
    current_user.teaches_subject_in_classroom? subject, classroom
  end
end
