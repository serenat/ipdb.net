class Podcast < ActiveRecord::Base
  has_many :people_podcasts, dependent: :destroy
  has_many :people, through: :people_podcasts
  has_many :users, through: :people
  has_many :episodes
  has_many :nominations
  has_many :awards, -> { distinct }, through: :nominations
  has_one :podcast_stat, dependent: :destroy
  accepts_nested_attributes_for :nominations, allow_destroy: true

  has_attached_file :image, styles: {medium: "250x250", thumb: "100x100>"},
    default_url: ->(attachment) { ActionController::Base.helpers.asset_path('microphone.png') }

  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  acts_as_commontable
  acts_as_votable
  letsrate_rateable
  acts_as_followable

  scope :with_awards, -> {
    includes(:awards)
  }
  scope :with_people, -> {
    includes(:people).includes(:users)
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

  def art
    image_url.blank? ? image : image_url
  end
end
