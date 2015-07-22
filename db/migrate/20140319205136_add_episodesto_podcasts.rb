class AddEpisodestoPodcasts < ActiveRecord::Migration
  def change
  	add_column :podcasts, :episodes, :string
  end
end
