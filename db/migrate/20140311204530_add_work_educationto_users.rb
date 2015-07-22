class AddWorkEducationtoUsers < ActiveRecord::Migration
def change
    add_column :users, :about, :text
    add_column :users, :work, :text
    add_column :users, :education, :text
  end
end
