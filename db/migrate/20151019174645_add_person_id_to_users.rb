class AddPersonIdToUsers < ActiveRecord::Migration
  def change
    add_belongs_to :users, :person, index: true
  end
end
