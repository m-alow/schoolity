class MessageSerializer < ActiveModel::Serializer
  attributes :id, :student, :message_type, :content_type, :content
  def student
    object.student.name
  end
end
