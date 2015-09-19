class MovePodcastAwardsColumnToAwardsTable < ActiveRecord::Migration

  class Podcast < ActiveRecord::Base
    has_and_belongs_to_many :awards
  end

  def change

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
end
