class ActivitySerializer < ActiveModel::Serializer
  attributes :id, :content_type, :content, :comments_count

  def comments_count
    object.comments.count
  end
end
