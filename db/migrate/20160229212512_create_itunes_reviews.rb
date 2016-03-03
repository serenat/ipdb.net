class CreateItunesReviews < ActiveRecord::Migration
  def change
    create_table :itunes_reviews do |t|
      t.references :podcast, index: true
      t.string    :itunes_id
      t.string    :author
      t.string    :title
      t.text      :content
      t.integer   :rating
      t.timestamp :commented_at

      t.timestamps null: false
    end
  end
end
