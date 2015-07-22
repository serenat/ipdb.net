class AddApprovedtoUserPodcast < ActiveRecord::Migration
  def change
  	add_column :user_podcasts, :approved, :boolean, :default => false
  end
end
