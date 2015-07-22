class AddSocialMediatoUsers < ActiveRecord::Migration
  def change
  	add_column :users, :facebook, :string
    add_column :users, :twitter, :string
    add_column :users, :pinterest, :string
    add_column :users, :instagram, :string
    add_column :users, :linkedin, :string
  end
end
