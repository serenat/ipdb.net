class RenameTypetoUsers < ActiveRecord::Migration
  def change
  	rename_column :users, :type, :membership
  end
end
