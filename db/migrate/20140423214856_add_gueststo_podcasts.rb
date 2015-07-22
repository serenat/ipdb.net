class AddGueststoPodcasts < ActiveRecord::Migration
  def change
    add_column :podcasts, :guest_id, :integer
    add_index :podcasts, :guest_id
  end
end
