class PersonPodcast < ActiveRecord::Base
  belongs_to :person
  belongs_to :podcast
  validates :podcast, :person, presence: true
  attr_reader :person_name, :podcast_name
end
