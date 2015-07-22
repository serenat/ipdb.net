class AddTypetoUserPodcast < ActiveRecord::Migration
  def change
	add_column :user_podcasts, :position, :text
  end
end
