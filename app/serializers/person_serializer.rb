class PersonSerializer < ActiveModel::Serializer
  attributes :name, :id

  has_many :podcasts
  has_one :user

  def podcasts
    Podcast.where(id: object.people_podcasts.approved.pluck(:podcast_id))
  end

  def user
    object.user || User.new
  end
end
