class PersonSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :name, :id, :profile_path

  has_many :podcasts
  has_one :user

  def podcasts
    Podcast.where(id: object.people_podcasts.approved.pluck(:podcast_id))
  end

  def profile_path
    person_path(object)
  end

  def user
    object.user || User.new
  end
end
