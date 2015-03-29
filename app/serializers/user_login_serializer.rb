class UserLoginSerializer < UserSerializer
  root :user

  attributes :authentication_token

  has_many :projects
  has_many :potential_projects

end
