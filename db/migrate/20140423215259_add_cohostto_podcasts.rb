class AddCohosttoPodcasts < ActiveRecord::Migration
  def change
    add_column :podcasts, :cohost_id, :integer
    add_index :podcasts, :cohost_id
  end
end
