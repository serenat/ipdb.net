class PodcastStat < ActiveRecord::Base
  belongs_to :podcast
  validates :id, uniqueness: { scope: :podcast_id }
end
