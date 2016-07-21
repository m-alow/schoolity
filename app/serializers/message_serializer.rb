class MessageSerializer < ActiveModel::Serializer
  attributes :id, :student, :message_type, :content_type, :content, :comments_count

  def student
    object.student.name
  end

  def comments_count
    object.comments.count
  end
end
