class CommentSerializer < ActiveModel::Serializer
  attributes :id, :user, :role, :body, :created_at, :updated_at, :owner

  def user
    object.user.name
  end

  def owner
    instance_options[:current_user] == object.user.id
  end
end
