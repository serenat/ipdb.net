class AddUsernametoUsers1 < ActiveRecord::Migration
  def change
      add_column :users, :username, :string
  end
end
