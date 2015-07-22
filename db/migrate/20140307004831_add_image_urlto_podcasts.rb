class AddImageUrltoPodcasts < ActiveRecord::Migration
  def change
  	add_column :podcasts, :image_url, :string
  end
end
