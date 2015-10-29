class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
    :trackable, :validatable, :database_authenticatable, :omniauthable

  belongs_to :person
  has_many :people_podcasts, through: :person
  has_one :identity, dependent: :destroy
  has_attached_file :profile_image, styles: { medium: '300x300>', thumb: '100x100>' },
    default_url: ->(attachment) { ActionController::Base.helpers.asset_path('ipdb.png') }
  validates_attachment_content_type :profile_image, :content_type => %w(image/jpeg image/jpg image/png)
  validates :email, presence: true, uniqueness: true
  validates :person, presence: true

  accepts_nested_attributes_for :person
  letsrate_rater
  acts_as_commontator
  acts_as_follower
  acts_as_voter

  def email_required?
    false
  end

  def email_changed?
    false
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
      if user.person
        user.person.name = auth.info.name if user.person.name.blank?
      else
        user.build_person(name: auth.info.name)
      end
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
