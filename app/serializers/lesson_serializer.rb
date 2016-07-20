class LessonSerializer < ActiveModel::Serializer
  attributes :id, :subject, :order, :content_type, :content, :activity, :behavior

  def activity
    ActiveModelSerializers::SerializableResource.new(object.activities.find_by student_id: student_id)
  end

  def behavior
    ActiveModelSerializers::SerializableResource.new(object.behaviors.find_by student_id: student_id)
  end

  def subject
    object.subject&.name
  end

  def student_id
    instance_options[:student_id]
  end
end
