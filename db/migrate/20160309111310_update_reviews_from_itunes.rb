class UpdateReviewsFromItunes < ActiveRecord::Migration
  def up
    Review.update_all(itunes: true)
  end

  def down
    Review.where(itunes: true).update_all(itunes: false)
  end
end
