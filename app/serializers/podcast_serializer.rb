class PodcastSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :name, :url

  def url
    podcast_path(object)
  end
end
