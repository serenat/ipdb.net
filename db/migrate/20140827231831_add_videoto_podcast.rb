class AddVideotoPodcast < ActiveRecord::Migration
  def change
  	add_column :podcasts, :video, :boolean
  end
end
