class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable, :database_authenticatable
  has_many :user_podcasts
  has_many :podcasts, :through => :user_podcasts
  has_attached_file :profile_image, :default_url => "/images/ipdb.png", :styles => { :medium => "300x300>", :thumb => "100x100>" }
  validates_attachment_content_type :profile_image, :content_type => %w(image/jpeg image/jpg image/png)
  letsrate_rater
  acts_as_commontator
  acts_as_follower
  acts_as_voter


  def self.search(search)
    if search
      where("concat(first_name,' ',last_name) like ?", "%#{search}%")
    else
      all
    end
  end

  def email_required?
    false
  end

  def email_changed?
    false
  end
end
