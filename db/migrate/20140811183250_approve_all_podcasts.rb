class ApproveAllPodcasts < ActiveRecord::Migration
  def change
  	Podcast.update_all(:approved => true)
  end
end
