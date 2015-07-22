class Podcast < ActiveRecord::Base
  has_many :user_podcasts
  has_many :users, :through => :user_podcasts
  has_many :episodes
  has_attached_file :image, :default_url => "/images/ipdb.png",  :styles => {:medium => "250x250", :thumb => "100x100>"}
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  acts_as_commontable
  acts_as_votable
  letsrate_rateable
  acts_as_followable

  def self.search(search)
    if search
      find(:all, :conditions => ['name LIKE ? or category LIKE?', "%#{search}%", "%#{search}%"  ])
    else
      find(:all)
    end
  end
end

