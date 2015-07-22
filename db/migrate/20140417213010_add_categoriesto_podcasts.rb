class AddCategoriestoPodcasts < ActiveRecord::Migration
  def change
	  add_column :podcasts, :category, :string
  end
end
