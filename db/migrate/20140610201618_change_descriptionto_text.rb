class ChangeDescriptiontoText < ActiveRecord::Migration
  def change
  	change_column :users, :description, :text, :limit => nil
  end
end
