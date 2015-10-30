class PersonPodcast < ActiveRecord::Base
  belongs_to :person
  belongs_to :podcast
  validates :podcast, :person, :position, presence: true
  validates :position, uniqueness: {scope: [:person, :position]}
  attr_reader :person_name, :podcast_name
  scope :approved, -> { where(approved: true) }
end
