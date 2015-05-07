class AddListToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :list, :string
    remove_column :tasks, :status, :integer
  end
end
