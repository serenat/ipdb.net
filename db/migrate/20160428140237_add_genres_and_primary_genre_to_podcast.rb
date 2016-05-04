class AddGenresAndPrimaryGenreToPodcast < ActiveRecord::Migration
  def change
    add_column :podcasts, :primary_genre, :string
    add_column :podcasts, :genres, :text, index: true
  end
end
