class RenameAwardsColumnOnPodcast < ActiveRecord::Migration
  def change
    rename_column :podcasts, :awards, :__awards
  end
end
