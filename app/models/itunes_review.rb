class ItunesReview < ActiveRecord::Base
  belongs_to :podcast
  stores_emoji_characters :content, :author, :title
end
