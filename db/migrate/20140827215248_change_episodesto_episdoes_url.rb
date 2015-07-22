class ChangeEpisodestoEpisdoesUrl < ActiveRecord::Migration
  def change
  	rename_column :podcasts, :episodes,  :episodes_url
  end
end
