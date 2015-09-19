class Podcast < ActiveRecord::Base
  has_many :user_podcasts
  has_many :users, :through => :user_podcasts
  has_many :episodes
  has_and_belongs_to_many :awards
  has_attached_file :image, :default_url => "/images/ipdb.png",  :styles => {:medium => "250x250", :thumb => "100x100>"}
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  acts_as_commontable
  acts_as_votable
  letsrate_rateable
  acts_as_followable

  scope :with_awards, -> {
    includes(:awards)
  }
  scope :awarded, -> {
    with_awards
      .joins("LEFT JOIN awards_podcasts ON podcasts.id = awards_podcasts.podcast_id")
      .where("awards_podcasts.award_id IS NOT NULL")
  }

  def hideplayer
    self[:hideplayer] || false
  end

  def self.search(search)
    if search
      where('name LIKE ?', "%#{search}%")
    else
      all
    end
  end
end

