class RenameItunesReviewsToReviews < ActiveRecord::Migration
  def change
    rename_table :itunes_reviews, :reviews
  end
end
