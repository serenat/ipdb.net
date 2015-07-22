class AddBadgetoPodcasts < ActiveRecord::Migration
  def change
    	add_column :podcasts, :pcaward, :boolean, default: false
  end
end
