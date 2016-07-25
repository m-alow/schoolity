class BehaviorSerializer < ActiveModel::Serializer
  belongs_to :student
  belongs_to :behaviorable
  attributes :id, :content_type, :content, :comments_count, :behaviorable_type

  def comments_count
    object.comments.count
  end
end
