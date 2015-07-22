class AddExplicttoPodcasts < ActiveRecord::Migration
  def change
     add_column :podcasts, :explicit, :boolean, default: false
  end
end
