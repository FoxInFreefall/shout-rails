class AddAuthenticationTokenToUsers < ActiveRecord::Migration
  def up
    add_column :users, :authentication_token, :string
    User.reset_column_information
    User.find_each do |user|
      user.ensure_authentication_token
      user.save!
    end
    change_column :users, :authentication_token, :string, null: false
    add_index :users, :authentication_token, unique: true
  end

  def down
    remove_column :users, :authentication_token
  end
end
