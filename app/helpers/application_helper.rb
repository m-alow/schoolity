module ApplicationHelper
  def school_classes_url
    school_school_classes_url
  end

  def school_classes_path
    school_school_classes_path
  end

  def classrooms_url
    school_school_class_classrooms_url
  end

  def classrooms_path
    school_school_class_classrooms_path
  end

  def flash_class(level)
    type = ''
    type = 'info' if level == :notice
    type = 'success' if level == :success
    type = 'danger' if level == :alert || level == :error
    "alert alert-#{type}"
  end
end
