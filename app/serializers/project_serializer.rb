class ProjectSerializer < ActiveModel::Serializer
  attributes :id, :name

  has_many :members, serializer: UserSerializer
  has_many :tasks
  has_many :tasks_todo, serializer: TaskSerializer
  has_many :tasks_doing, serializer: TaskSerializer
  has_many :tasks_done, serializer: TaskSerializer

  def tasks_todo
    object.tasks.todo
  end

  def tasks_doing
    object.tasks.doing
  end

  def tasks_done
    object.tasks.done
  end

end
