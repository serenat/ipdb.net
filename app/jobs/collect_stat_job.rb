class CollectStatJob < ActiveJob::Base
  queue_as :default

  def perform(podcast_id, event, ip_address)
    podcast = Podcast.find(podcast_id)
    podcast_stat = PodcastStat.where(podcast_id: podcast_id).first_or_initialize

    podcast_event = PodcastEvent.new(
      podcast_id: podcast.id,
      ip_address: ip_address,
      event: event
    )

    if podcast_event.save
      podcast_stat.increment("#{event}s")
      podcast_stat.increment("unique_#{event}s")
    elsif podcast_event.errors[:event].blank?
      podcast_stat.increment("#{event}s")
    end
    podcast_stat.save!
  end
end
