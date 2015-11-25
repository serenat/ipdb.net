class PodcastSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :name, :url, :id

  def url
    podcast_path(object)
  end
end
