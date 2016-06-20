class UserSerializer < ActiveModel::Serializer
  attributes :email, :authentication_token, :first_name, :last_name
end
