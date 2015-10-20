class Person < ActiveRecord::Base
  has_one :user
  has_many :people_podcasts, dependent: :destroy
  has_many :podcasts, through: :people_podcasts
  validates :name, presence: :true
end
