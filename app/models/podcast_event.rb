class PodcastEvent < ActiveRecord::Base
  belongs_to :podcast
  validates :event, inclusion: { in: %w(hit download share) }
  validates :podcast_id, uniqueness: { scope: [:ip_address, :event] }
end
