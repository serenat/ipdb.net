class CreatePodcastStats < ActiveRecord::Migration
  def change
    create_table :podcast_stats do |t|
      t.belongs_to :podcast, index: true
      t.integer :hits, null: false, default: 0
      t.integer :unique_hits, null: false, default: 0
      t.integer :downloads, null: false, default: 0
      t.integer :unique_downloads, null: false, default: 0
      t.integer :shares, null: false, default: 0
      t.integer :unique_shares, null: false, default: 0
      t.integer :itunes_review_count, null: false, default: 0
      t.decimal :itunes_rating, precision: 6, scale: 5, null: false, default: 0
      t.timestamps null: false
    end
  end
end
