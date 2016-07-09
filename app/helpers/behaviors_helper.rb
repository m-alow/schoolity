module BehaviorsHelper
  def behaviors_path behavior
    send "#{behavior.behaviorable_type.underscore}_behaviors_path", behavior.behaviorable
  end
end
