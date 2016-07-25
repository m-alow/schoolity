class ActivitySerializer < ActiveModel::Serializer
  belongs_to :student
  belongs_to :lesson
  attributes :id, :content_type, :content, :comments_count, :student

  def comments_count
    object.comments.count
  end
end
