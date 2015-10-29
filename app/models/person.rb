class Person < ActiveRecord::Base
  has_one :user
  has_many :people_podcasts, dependent: :destroy
  has_many :podcasts, through: :people_podcasts
  validates :name, presence: :true

  scope :uniq_name, -> { group(:name) }

  def self.search(search)
    if search
      where("name like ?", "%#{search}%")
    else
      all
    end
  end
end
