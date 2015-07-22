class AddppffToPodcasts < ActiveRecord::Migration
  def change
    	add_column :podcasts, :ppff, :integer
  end
end
