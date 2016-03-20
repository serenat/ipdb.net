class Relations
  attr_reader :user, :podcast

  def initialize(user, podcast)
    @user = user
    @podcast = podcast
  end

  def kind_of_host?
    PersonPodcast.exists?(
      person_id: user.person_id,
      podcast_id: podcast.id,
      position: ['Host', 'Co-Host'],
      approved: true
    )
  end
end
