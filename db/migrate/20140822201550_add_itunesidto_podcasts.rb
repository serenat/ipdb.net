class AddItunesidtoPodcasts < ActiveRecord::Migration
  def change
  	add_column :podcasts, :itunes_id, :integer
  end
end
