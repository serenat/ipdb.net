class AddFeedUrlToPodcasts < ActiveRecord::Migration
  def change
    add_column :podcasts, :feed_url, :string
  end
end
