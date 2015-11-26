class Company < ActiveRecord::Base
  include PrettyId
  has_many :companies_people, dependent: :destroy
  has_many :people, through: :companies_people
  has_many :companies_podcasts, dependent: :destroy
  has_many :podcasts, through: :companies_podcasts
  alias_attribute :owner_id, :user_id

  validates :name, presence: true, allow_blank: false

  has_attached_file :image, styles: {medium: '256x256', thumb: '128x128', small: '64x64'},
    default_url: ':company_placeholder'
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  acts_as_commontable
  acts_as_votable
  letsrate_rateable

  scope :approved, -> { where(approved: true) }

  def self.search(search)
    if search
      where('name LIKE ?', "%#{search}%")
    else
      all
    end
  end

  # ABILITY
  # Monkey patch can_rate? method for Letsrate gem.
  # Regular user (not payed subscriber) can't rate. As well as guest(handled by super)
  def can_rate?(user, dimension=nil)
    return false if user && user.regular?
    super
  end

  def address
    [city, state, country].reject(&:blank?).join(', ')
  end
end
