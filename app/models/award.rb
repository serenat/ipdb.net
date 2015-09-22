class Award < ActiveRecord::Base
  has_many :nominations
  has_many :podcasts, :through => :nominations

  NAMES = ['Podcast Award Nominee', 'Podcast Award Winner', 'Stitcher Award Nominee',
    'Stitcher Award Winner', 'Parsec Award Nominee', 'Parsec Award Winner',
    'IPDb Nominee', 'IPDb Winner']

  def nominations_list(podcast_id)
    nominations.where(podcast_id: podcast_id).map(&:description).compact.join(', ')
  end
end
