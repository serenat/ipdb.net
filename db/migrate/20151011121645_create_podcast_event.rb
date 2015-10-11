class CreatePodcastEvent < ActiveRecord::Migration
  def change
    create_table :podcast_events do |t|
      t.belongs_to :podcast, index: true
      t.string :ip_address
      t.string :event
    end
  end
end
