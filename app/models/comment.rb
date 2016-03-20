class Comment < ActiveRecord::Base
	belongs_to :commentable, polymorphic: true
  belongs_to :user

  validates :commentable, presence: true
  validates :content, presence: true, length: {maximum: 300}
  validates :user, uniqueness: {scope: :commentable}
  validate :created_within_fifteen_minutes?, if: :persisted?

  def destroy
    raise ActiveRecord::RecordInvalid.new(self) unless created_within_fifteen_minutes?
    super
  end

  private

  def created_within_fifteen_minutes?
    if Time.current > (created_at + 15.minutes)
      errors.add(:updated_at, "I'm sorry Dave. It's too late to update.")
      false
    else
      true
    end
  end
end
