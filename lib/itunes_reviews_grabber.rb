require 'open-uri'

class ItunesReviewsGrabber
  MAX_PAGE_NUMBER  = 10
  REVIEWS_PER_PAGE = 50

  def initialize(podcast)
    @podcast_id = podcast.id
    @itunes_id = podcast.itunes_id
  end

  def last_reviews(until_date = nil)
    result = []
    (1..MAX_PAGE_NUMBER).each do |page_number|
      reviews = get_reviews_from_page(page_number)
      new_reviews = filter_reviews(reviews, until_date)
      result += new_reviews

      if last_page_with_new_reviews?(new_reviews)
        return result
      end
    end
    result
  end

  private

  attr_reader :itunes_id, :podcast_id

  def get_reviews_from_page(page_number)
    page = get_page(page_number)
    reviews = ItunesReviewsParser.new(page).reviews
  end

  def get_page(page_number)
    tries = 3
    begin
      open url(page_number)
    rescue StandardError => e
      tries -= 1
      if tries > 0
        sleep (3 - tries)
        retry
      else
        Loggers::Monitoring.info(
          "Fail; id: #{podcast_id}; page: #{page_number}; error: #{e.message};"
        )
        nil
      end
    end
  end

  def url(page_number)
    "https://itunes.apple.com/us/rss/customerreviews/page=#{page_number}/id=#{itunes_id}/sortBy=mostRecent/xml"
  end

  def filter_reviews(reviews, until_date)
    if until_date
      reviews.select { |review| review[:commented_at] > until_date }
    else
      reviews
    end
  end

  def last_page_with_new_reviews?(reviews)
    reviews.length < REVIEWS_PER_PAGE
  end

end
