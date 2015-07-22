class AddAwardtoPodcasts < ActiveRecord::Migration
  def change
     add_column :podcasts, :pcaward2, :boolean, default: false
     add_column :podcasts, :pcaward3, :boolean, default: false
  end
end
