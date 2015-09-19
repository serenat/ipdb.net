class Award < ActiveRecord::Base
  has_and_belongs_to_many :podcasts

  NAMES = ['Podcast Award Nominee', 'Podcast Award Winner', 'Stitcher Award Nominee',
    'Stitcher Award Winner', 'Parsec Award Nominee', 'Parsec Award Winner',
    'IPDb Nominee', 'IPDb Winner'] 
end
