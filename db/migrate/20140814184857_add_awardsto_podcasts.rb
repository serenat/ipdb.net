class AddAwardstoPodcasts < ActiveRecord::Migration
  def change
  	add_column :podcasts, :awards, :string
  end
end
