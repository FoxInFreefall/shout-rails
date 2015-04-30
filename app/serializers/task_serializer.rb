class TaskSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :project_id

end
