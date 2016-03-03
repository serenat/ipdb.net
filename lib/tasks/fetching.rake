namespace :fetch do
  task :itunes_reviews => :environment do
    Loggers::Monitoring.info "=========================================="
    Loggers::Monitoring.info "Starting Itunes reviews fetching session."
    Loggers::Monitoring.info "Time: #{DateTime.now}"
    Loggers::Monitoring.info "=========================================="

    Podcast.find_in_batches(batch_size: 20000) do |batch|
      start = batch.first.id
      finish = batch.last.id
      FetchItunesReviewsJob.perform_later(start, finish)
    end
  end
end
