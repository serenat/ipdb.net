class AddMyColumnToPodcast < ActiveRecord::Migration
  def change
    add_column :podcasts, :Name, :text
  end
end
