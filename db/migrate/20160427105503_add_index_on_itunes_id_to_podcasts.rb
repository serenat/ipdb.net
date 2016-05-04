class AddIndexOnItunesIdToPodcasts < ActiveRecord::Migration
  def change
    add_index :podcasts, :itunes_id
  end
end
