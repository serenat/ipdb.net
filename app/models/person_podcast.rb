class PersonPodcast < ActiveRecord::Base
  belongs_to :person
  belongs_to :podcast
  validates :podcast, :person, :position, presence: true
  attr_reader :person_name, :podcast_name
  scope :approved, -> { where(approved: true) }
end
