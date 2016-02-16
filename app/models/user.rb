class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
    :trackable, :validatable, :database_authenticatable, :omniauthable

  belongs_to :person
  has_many :people_podcasts, through: :person
  has_many :podcasts, through: :people_podcasts

  has_many :incomings, foreign_key: :recipient_id, dependent: :destroy
  has_many :incoming_messages, through: :incomings, source: :message
  has_many :sent_messages, class_name: 'Message',
                           foreign_key: :sender_id

  has_attached_file :profile_image, styles: { medium: '256x256>', thumb: '128x128', small: '64x64' },
    default_url: ':user_placeholder'

  validates_attachment_content_type :profile_image, :content_type => %w(image/jpeg image/jpg image/png)
  validates :email, :person, presence: true, uniqueness: true
  validates :membership, inclusion: { in: [nil, 'basic', 'silver'],
    message: "%{value} is not a valid membership" }

  accepts_nested_attributes_for :person

  letsrate_rater
  acts_as_commontator
  acts_as_follower
  acts_as_voter

  before_create :create_stripe_customer

  def email_required?
    false
  end

  def email_changed?
    false
  end

  def self.from_oauth(auth, password)
    user = User.new(
      email: auth.info.email,
      provider: auth.provider,
      uid: auth.uid,
      facebook: auth.uid,
      password: password,
      password_confirmation: password
    )
    user.build_person(name: auth.info.name)
    user.save
    user
  end

  def without_plan?
    membership == nil
  end

  def basic?
    membership == 'basic'
  end

  def payed_subscriber?
    !without_plan? && (membership != 'basic')
  end

  def silver?
    membership == 'silver'
  end

  def gold?
    membership == 'gold'
  end

  def platinum?
    membership == 'platinum'
  end

  def host?
    PersonPodcast.exists?(person_id: person_id, position: 'Host', approved: true)
  end

  def select_basic_plan
    if without_plan?
      self.membership = 'basic'
      self.save!
    else
      raise Errors::User::HasPlanAlready
    end
  end

  def select_silver_plan(card_token)
    if without_plan?
      self.membership = 'silver'
      self.card_token = card_token
      self.create_stripe_customer
      self.save!
    else
      raise Errors::User::HasPlanAlready
    end
  end

  def create_stripe_customer
    if membership && membership != 'basic'
      customer_data = {email: email, source: card_token, plan: membership}
      customer = Stripe::Customer.create customer_data
      customer_id = customer.id
      active_untile = 15.days.from_now
    end
  end

end
