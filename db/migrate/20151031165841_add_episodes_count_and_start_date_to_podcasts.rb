class AddEpisodesCountAndStartDateToPodcasts < ActiveRecord::Migration
  def change
    add_column :podcasts, :episodes_count, :integer, default: 0
    add_column :podcasts, :start_date, :date
  end
end
