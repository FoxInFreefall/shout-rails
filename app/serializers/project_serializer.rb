class ProjectSerializer < ActiveModel::Serializer
  attributes :id, :name

  has_many :members, serializer: UserSerializer
  has_many :tasks

end
