class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :authentication_token

  has_many :projects
  has_many :potential_projects

end
