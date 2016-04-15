class FetchItunesReviewsJob < ActiveJob::Base
  queue_as :default

  around_perform do |job, block|
    log_helper "=========================================="
    log_helper "Starting Itunes reviews fetching session."
    log_helper "Start Time: #{DateTime.now}"
    log_helper "=========================================="

    block.call

    log_helper "=========================================="
    log_helper "Itunes reviews fetching session finished."
    log_helper "End Time: #{DateTime.now}"
    log_helper "=========================================="
  end

  def perform(from = nil)
    fetched = 0
    Podcast.find_in_batches(batch_size: 200, start: from).with_index do |podcasts, index|

      podcasts.each do |podcast|
        grabber = ItunesReviewsGrabber.new(podcast)
        until_date = podcast.last_itunes_review.try(:commented_at)
        reviews = grabber.last_reviews(until_date)
        if reviews.count > 0
          log_helper("Success; id: #{podcast.id}; reviews: #{reviews.count};")
        end
        podcast.reviews.create(reviews)
        sleep(0.2)
      end
      log_helper("#{fetched += podcasts.length} podcasts was fetched")
      sleep(7)
    end
  end

  private

  def log_helper(message)
    Loggers::Monitoring.info(message)
  end
end
