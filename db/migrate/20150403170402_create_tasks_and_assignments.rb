class CreateTasksAndAssignments < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string    :title
      t.string    :description
      t.datetime  :due_date
      t.integer   :status,  default: 0
      t.belongs_to  :project

      t.timestamps
    end

    create_table :assignments do |t|
      t.belongs_to  :task
      t.belongs_to  :user

      t.timestamps
    end
  end
end
