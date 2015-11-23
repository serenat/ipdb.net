class Person < ActiveRecord::Base
  include PrettyId
  has_one :user
  has_many :people_podcasts, dependent: :destroy
  has_many :podcasts, through: :people_podcasts
  has_many :companies_people, dependent: :destroy
  has_many :companies, through: :companies_people

  validates :name, presence: :true

  scope :uniq_name, -> { group(:name) }

  def host_podcasts
    podcasts.joins(:people_podcasts)
      .where('people_podcasts.position = ? AND people_podcasts.approved = ?', 'Host', true)
  end

  def self.search(search)
    if search
      where("name like ?", "%#{search}%")
    else
      all
    end
  end

  def profile_image
    user && user.profile_image
  end

  def name=(s)
    super s.titleize
  end
end
