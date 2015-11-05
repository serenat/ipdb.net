namespace :update do
  task :person_slug => :environment do
    count = 0
    Person.find_in_batches(batch_size: 100) do |people|
      people.each do |p|
        p.update(slug: nil)
      end
      puts "Updated #{(count+=1)*100} slugs"
    end
  end

  task :podcast_slug => :environment do
    count = 0
    Podcast.find_in_batches(batch_size: 1000) do |podcasts|
      podcasts.each do |p|
        p.update(slug: nil)
      end
      puts "Updated #{(count+=1)*1000} slugs"
    end
  end
end
