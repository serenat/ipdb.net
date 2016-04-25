class PodcastDecorator
  attr_reader :podcast, :feed
  delegate :id, :followers_count, :followers, :hideplayer, :user_approved?,
    :video, :users, :awards, :messages, :average, :people_podcasts, :to_param, to: :podcast

  def initialize(podcast)
    @podcast = podcast
    @feed = get_rss()
  end

  def title
    feed ? feed.title : podcast.name
  end

  def description
    feed ? feed.description : podcast.description
  end

  def art
    podcast.image_url.blank? ? podcast.image : podcast.image_url
  end

  def number_of_episodes
    adjustment = feed ? feed.entries.count : 0
    podcast.episodes_count + adjustment
  end

  def episodes
    feed ? feed.entries : []
  end

  def episodes_as_json
    episodes.map do |episode|
      {
        entry_id: episode.entry_id,
        title: episode.title,
        published: episode.published,
        description: (episode.itunes_subtitle || episode.itunes_summary || episode.summary).truncate(300),
        source: episode.enclosure_url,
        source_type: episode.enclosure_type
      }
    end.as_json
  end

  private

  def feed
    @feed ||= get_rss()
  end

  def get_rss
    xml = Faraday.get(podcast.feed_url).body
    Feedjira::Feed.parse_with Feedjira::Parser::ITunesRSS, xml
  rescue StandardError => e
    nil
  end
end
