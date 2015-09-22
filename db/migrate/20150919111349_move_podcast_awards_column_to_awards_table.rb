class MovePodcastAwardsColumnToAwardsTable < ActiveRecord::Migration

  class Podcast < ActiveRecord::Base
    has_and_belongs_to_many :awards
    scope :awarded, -> {
      joins("LEFT JOIN awards_podcasts ON podcasts.id = awards_podcasts.podcast_id").where("awards_podcasts.award_id IS NOT NULL")
    }
  end

  def up
    Podcast.where.not(__awards: nil).each do |podcast|
      unless podcast.__awards.blank?
        award = Award.find_by(name: podcast.__awards)
        if award
          podcast.awards << award
          podcast.save!
        end
      end
    end
  end

  def down
    Podcast.awarded.each do |podcast|
      podcast.awards.delete_all
    end
  end
end
