class Review < ActiveRecord::Base
  belongs_to :podcast
  belongs_to :user
  has_one :comment, as: :commentable, dependent: :destroy

  validates :podcast, presence: true
  validates :rating, presence: true,
    numericality: {only_integer: true, greater_than: 0, less_than_or_equal_to: 5}
  validates :title, presence: true, length: {maximum: 35}, unless: :itunes
  validates :content, presence: true, length: {maximum: 300}, unless: :itunes
  validates :user, uniqueness: {scope: :podcast}, unless: :itunes

  before_create :set_commented_at, unless: :itunes

  stores_emoji_characters :content, :author, :title

  private

  def set_commented_at
    self.commented_at = created_at
  end

end
