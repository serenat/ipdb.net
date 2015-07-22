class AddImdbtoUser < ActiveRecord::Migration
  def change
  	add_column :users, :imdb, :string
  end
end
