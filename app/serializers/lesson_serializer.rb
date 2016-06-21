class LessonSerializer < ActiveModel::Serializer
  attributes :subject, :order, :content_type, :content, :activity

  def activity
    ActiveModelSerializers::SerializableResource.new(object.activities.find_by student_id: student_id)
  end

  def subject
    object.subject&.name
  end

  def student_id
    instance_options[:student_id]
  end
end
