require 'csv'
require 'nokogiri'

namespace :scrape do
  task :itunes_rating, [:start_from, :batch_timeout, :request_timeout, :mode] => :environment do |task, args|
    begin
      scrapper = Scrapper.new(args.start_from, args.batch_timeout, args.request_timeout, args.mode)
      scrapper.scrape!
      puts 'Done!'
    rescue SystemExit, Interrupt => e
      scrapper.output.close
      puts 'EXIT!'
      exit
    end
  end
end

class Scrapper
  attr_reader :output

  def initialize(start_from, batch_timeout, request_timeout, mode)
    @output = CSV.open(Rails.root.join('lib/data', 'itunes_rating.csv'), mode || 'wb')
    @start_from = start_from.to_i
    @batch_timeout = batch_timeout.present? ? batch_timeout.to_f : 1.2
    @request_timeout = request_timeout.present? ? request_timeout.to_f : 1.2
    @count = 0
  end

  def scrape!
    puts 'Lets go'
    count = 0
    Podcast.find_in_batches(batch_size: 10, start: @start_from) do |podcasts|
      sleep rand(0.1..@batch_timeout) || 1.0
      podcasts.each do |p|
        scrape_rating(p)
      end
      puts "Scraped #{(count+=1)*10} podcasts"
    end
  end

  def scrape_rating(podcast)
    sleep rand(0.1..@request_timeout) || 1.0
    if itunes_id = podcast.itunes_id
      url = "https://itunes.apple.com/us/podcast/id#{itunes_id}"
      doc = Nokogiri::HTML(open(url))
      rating = doc.at_css('.rating span[itemprop="ratingValue"]').try(:text)
      if rating
        rc = doc.at_css('.rating span[itemprop="reviewCount"]').try(:text)
        review_count = /^(\d+)/.match(rc)[1] if rc

        output << [itunes_id, rating, review_count]
        puts "Podcast with id: #{podcast.id} and itunes_id: #{itunes_id} scraped successfully"
      else
        puts "No rating for id: #{podcast.id}; itunes_id: #{itunes_id}"
      end
    end
  rescue OpenURI::HTTPError => e
    puts e.message
    puts "podcast id: #{podcast.id}; itunes_id: #{itunes_id}"
  rescue StandardError => e
    puts 'Uups!'
    puts e.message

    @count = 0 if @count > 6
    @count += 1

    sleep great_timeout = @batch_timeout * 2 * @count * rand(1.0..1.4)

    puts "Great timeout was: #{great_timeout}"
    retry
  end
end
