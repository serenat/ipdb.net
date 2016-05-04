namespace :populate do
  task :itunes_id, [:start_from, :batch_size] => :environment do |task, args|
    b_size = args.batch_size || 10
    count = 0

    Podcast.find_in_batches(batch_size: b_size, start: args.start_from) do |podcasts|
      podcasts.each do |p|
        if url = p.episodes_url
          itunes_id = /\/id(\d+)/.match(url).try(:[], 1)
          if itunes_id.presence
            p.update_attribute(:itunes_id, itunes_id)
            puts "Podcast with id: #{p.id} and itunes_id: #{itunes_id} filled"
          else
            puts "No itunes_id for id: #{p.id}"
          end
        end
      end
      puts "Filled #{(count+=1)*10} podcasts"
    end
  end

  task :itunes_rating => :environment do
    CSV.foreach(Rails.root.join('lib/data', 'itunes_rating.csv')) do |row|
      if podcast = Podcast.find_by(itunes_id: row[0])
        stat = PodcastStat.find_or_initialize_by(podcast_id: podcast.id)
        stat.itunes_rating = row[1]
        stat.itunes_review_count = row[2]
        stat.save!
        puts "Podcast id: #{podcast.id} is filled"
      else
        puts "Podcast with itunes_id: #{row[0]} is not found"
      end
    end
  end

  task :feed_url => :environment do
    CSV.foreach(Rails.root.join('lib/data', 'feeds.csv')) do |row|
      if podcast = Podcast.find_by(itunes_id: row[0])
        podcast.update_attribute(:feed_url, row[1])
        print '.'
      else
        puts "Podcast with itunes_id: #{row[0]} is not found"
      end
    end
  end

  task :genres => :environment do
    CSV.foreach(Rails.root.join('lib/data', 'itunes_lookup_table.csv')) do |row|
      if podcast = Podcast.find_by(itunes_id: row[0])
        h = JSON.parse(row[1])
        genres = h['genres'].select {|genre| genre != 'Podcasts'}
        podcast.update_columns(genres: ",#{genres.join(',')},", primary_genre: h['primaryGenreName'])
        print '.'
      else
        puts "Podcast with itunes_id: #{row[0]} is not found"
      end
    end
  end
end
