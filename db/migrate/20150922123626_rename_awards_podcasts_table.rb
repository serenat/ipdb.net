class RenameAwardsPodcastsTable < ActiveRecord::Migration
  def change
    rename_table :awards_podcasts, :nominations
  end
end
