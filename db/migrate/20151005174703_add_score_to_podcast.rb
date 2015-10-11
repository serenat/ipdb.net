class AddScoreToPodcast < ActiveRecord::Migration
  def change
    add_column :podcasts, :score, :decimal, precision: 6, scale: 5, null: false, default: 0, index: true
  end
end
