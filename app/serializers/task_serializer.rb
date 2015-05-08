class TaskSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :project_id

  has_many :members, serializer: UserSerializer

end
