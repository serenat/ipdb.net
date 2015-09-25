class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
    :trackable, :validatable, :database_authenticatable, :omniauthable

  has_many :user_podcasts
  has_many :podcasts, :through => :user_podcasts
  has_one :identity
  has_attached_file :profile_image, :default_url => "ipdb.png", :styles => { :medium => "300x300>", :thumb => "100x100>" }
  validates_attachment_content_type :profile_image, :content_type => %w(image/jpeg image/jpg image/png)
  validates :email, presence: true, uniqueness: true

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

  def name
    "#{first_name} #{last_name}".strip
  end

  def name=(name)
    self.first_name, self.last_name = name.try(:split)
  end

  def any_name
    name.blank? ? username : name
  end

  def password_required?
    super && !identity
  end

  def self.find_for_oauth(auth)
    identity = Identity.find_for_oauth(auth)
    user = identity.user
    # Create the user if needed
    if user.nil?
      user = User.find_or_initialize_by(email: auth.info.email)

      user.name = auth.info.name if user.name.blank?
      user.profile_image = open(auth.info.image) if !user.profile_image.exists? && !auth.extra.raw_info.picture.data.is_silhouette
      user.facebook = auth.uid if user.facebook.blank?

      identity.user = user
      identity.save
    end
    user
  end

  def self.new_with_session(params, session)
    if auth = session['devise.user_attributes']
      super.tap do |user|
        user.identity = Identity.find_for_oauth(auth)

        user.email = auth.info.email
        user.name = auth.info.name
        user.profile_image = open(auth.info.image) unless auth.extra.raw_info.picture.data.is_silhouette
        user.facebook = auth.uid

        user.valid?
      end
    else
      super
    end
  end
end
