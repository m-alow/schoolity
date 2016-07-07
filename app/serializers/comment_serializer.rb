class CommentSerializer < ActiveModel::Serializer
  attributes :id, :user, :role, :body, :created_at, :updated_at

  def user
    object.user.name
  end
end
