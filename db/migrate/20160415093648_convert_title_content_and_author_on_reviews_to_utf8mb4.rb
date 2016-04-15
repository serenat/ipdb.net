class ConvertTitleContentAndAuthorOnReviewsToUtf8mb4 < ActiveRecord::Migration
  def up
    Review.delete_all

    execute "ALTER TABLE reviews CHANGE title title VARCHAR(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin"
    execute "ALTER TABLE reviews CHANGE author author VARCHAR(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin"
    execute "ALTER TABLE reviews CHANGE content content TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_bin"
  end

  def down
  end
end
