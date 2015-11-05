class AddSlugToPodcasts < ActiveRecord::Migration
  def change
    add_column :podcasts, :slug, :string
    add_index :podcasts, :slug
  end
end
