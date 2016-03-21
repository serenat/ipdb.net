class FetchItunesReviewsJob < ActiveJob::Base
  queue_as :default

  around_perform do |job, block|
    log_helper "=========================================="
    log_helper "Starting Itunes reviews fetching session."
    log_helper "Time: #{DateTime.now}"
    log_helper "=========================================="

    block.call

    log_helper "=========================================="
    log_helper "Itunes reviews fetching session finished."
    log_helper "Time: #{DateTime.now}"
    log_helper "=========================================="
  end

  def perform
    fetched = 0
    Podcast.find_in_batches.with_index do |podcasts, index|
      log_helper("start fetch #{index + 1} batch")

      podcasts.each do |podcast|
        grabber = ItunesReviewsGrabber.new(podcast.itunes_id)
        until_date = podcast.last_itunes_review.try(:commented_at)
        reviews = grabber.last_reviews(until_date)
        podcast.reviews.create(reviews)
      end

      log_helper("#{fetched += podcasts.length} podcasts was fetched")
    end
  end

  private

  def log_helper(message)
    Loggers::Monitoring.info(message)
  end
end
