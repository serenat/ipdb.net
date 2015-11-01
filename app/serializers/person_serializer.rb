class PersonSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :name, :id, :profile_path, :profile_image

  has_many :podcasts

  def podcasts
    Podcast.where(id: object.people_podcasts.approved.pluck(:podcast_id))
  end

  def profile_path
    person_path(object)
  end

  def profile_image
    object.user ? object.user.profile_image : ActionController::Base.helpers.asset_path('user.png')
  end
end
