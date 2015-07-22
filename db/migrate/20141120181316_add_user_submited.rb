class AddUserSubmited < ActiveRecord::Migration
  def change
  	add_column :podcasts, :user_approved, :boolean, :default => false
  end
end
