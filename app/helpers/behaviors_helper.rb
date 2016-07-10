module BehaviorsHelper
  def behaviors_path behavior
    send "#{behavior.behaviorable_type.underscore}_behaviors_path", behavior.behaviorable
  end

  def update_behavior_path behavior
    send "#{behavior.behaviorable_type.underscore}_student_behavior_path", behavior.behaviorable, behavior.student
  end
end
