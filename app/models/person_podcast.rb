class PersonPodcast < ActiveRecord::Base
  POSITIONS = [
    'Host', 'Co-host', 'Guest', 'Artwork', 'Music', 'Sound Engineer', 'Performer'
  ]

  belongs_to :person
  belongs_to :podcast
  validates :podcast, :person, :position, presence: true
  validates :position, uniqueness: {scope: [:person, :podcast]}
  attr_reader :person_name, :podcast_name
  scope :approved, -> { where(approved: true) }
  scope :fully_approved, -> do
    approved
      .joins(:podcast)
      .where('podcasts.approved' => true)
  end

  def person_name
    person && person.name
  end
end
