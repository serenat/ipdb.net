class RenameFirstNameLastNameAndUsernameOnUsers < ActiveRecord::Migration
  def change
    rename_column :users, :first_name, :__first_name
    rename_column :users, :last_name, :__last_name
    rename_column :users, :username, :__username
  end
end
