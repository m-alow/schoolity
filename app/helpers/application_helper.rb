module ApplicationHelper
  def flash_class(level)
    type = ''
    type = 'info' if level == :notice
    type = 'success' if level == :success
    type = 'danger' if level == :alert || level == :error
    "alert alert-#{type}"
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
end
