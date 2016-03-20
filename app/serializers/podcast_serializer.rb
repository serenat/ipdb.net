class PodcastSerializer < BaseSerializer
  attributes :name, :url, :id

  def url
    podcast_path(object)
  end
end
