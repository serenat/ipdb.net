class FetchItunesReviewsJob < ActiveJob::Base
  queue_as :default

  around_perform do |job, block|
    log_helper(job.arguments.first, job.arguments.last, "is started")

    block.call

    log_helper(job.arguments.first, job.arguments.last, "is done")
  end

  def perform(start, finish)
    fetched = 0
    Podcast.find_in_batches(start: start).with_index do |podcasts, index|
      log_helper(start, finish, "start fetch #{index + 1} batch")

      podcasts.each do |podcast|
        return if podcast.id > finish

        grabber = ItunesReviewsGrabber.new(podcast.itunes_id)
        until_date = podcast.last_itunes_review.try(:commented_at)
        reviews = grabber.last_reviews(until_date)
        podcast.itunes_reviews.create(reviews)
      end

      log_helper(start, finish, "#{fetched += podcasts.length} podcasts was fetched")
    end
  end

  private

  def log_helper(start, finish, message)
    Loggers::Monitoring.info("FetchReviewsJob(#{start},#{finish}): #{message}")
  end
end
