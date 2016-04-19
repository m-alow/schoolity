module ApplicationHelper
  def flash_class(level)
    type = ''
    type = 'info' if level == :notice
    type = 'success' if level == :success
    type = 'danger' if level == :alert || level == :error
    "alert alert-#{type}"
  end
end
