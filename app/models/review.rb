class Review < ActiveRecord::Base
  belongs_to :podcast
  belongs_to :user
  has_one :comment, as: :commentable, dependent: :destroy

  validates :podcast, presence: true
  validates :title, presence: true, length: {maximum: 35}
  validates :rating, presence: true,
    numericality: {only_integer: true, greater_than: 0, less_than_or_equal_to: 5}
  validates :content, presence: true, length: {maximum: 300}
  validates :user, uniqueness: {scope: :podcast}, unless: :itunes
  validate :created_within_fifteen_minutes?, if: :persisted?

  before_create :set_commented_at, unless: :itunes

  stores_emoji_characters :content, :author, :title

  private

  def set_commented_at
    self.commented_at = created_at
  end
end
