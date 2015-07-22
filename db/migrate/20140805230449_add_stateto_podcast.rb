class AddStatetoPodcast < ActiveRecord::Migration
  def change
  	add_column :podcasts, :approved, :boolean, default: false
  end
end
