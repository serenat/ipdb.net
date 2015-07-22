class CreatePodcastSearches < ActiveRecord::Migration
  def change
    create_table :podcast_searches do |t|

      t.timestamps
    end
  end
end
