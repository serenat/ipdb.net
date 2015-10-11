class Podcast < ActiveRecord::Base
  has_many :user_podcasts
  has_many :users, :through => :user_podcasts
  has_many :episodes
  has_many :nominations
  has_many :awards, -> { distinct }, through: :nominations
  has_one :podcast_stat, dependent: :destroy
  accepts_nested_attributes_for :nominations, allow_destroy: true

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
      .joins("LEFT JOIN nominations ON podcasts.id = nominations.podcast_id")
      .where("nominations.award_id IS NOT NULL")
  }
  scope :approved, -> { where(approved: true) }
  scope :by_score, -> { order(score: :desc) }

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
