class BehaviorSerializer < ActiveModel::Serializer
  belongs_to :student
  attributes :id, :content_type, :content, :comments_count

  def comments_count
    object.comments.count
  end
end
