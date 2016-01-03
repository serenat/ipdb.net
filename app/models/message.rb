class Message < ActiveRecord::Base
  belongs_to :sender, class_name: 'User'
  belongs_to :podcast
  validates :subject, :body, :sender_id, :podcast_id, presence: true
  validate :ownership

  scope :desc, -> { order(created_at: :desc) }

  private

  def ownership
    podcasts_ids = PersonPodcast.where(person_id: sender.person_id, position: 'Host').pluck(:podcast_id)
    unless podcasts_ids.include?(podcast_id)
      errors[:base] << 'only podcast host can send message to followers'
    end
  end
end
