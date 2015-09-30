class Identity < ActiveRecord::Base
  belongs_to :user

  validates :uid, :provider, presence: true
  validates :uid, uniqueness: { scope: :provider }

  def self.find_for_oauth(auth)
    where(uid: auth.uid, provider: auth.provider).first_or_initialize.tap do |i|
      i.uid = auth.uid
      i.provider = auth.provider
      i.oauth_token = auth.credentials.oauth_token

      # important. We show share modal only once. For new users.
      i.shared = true if i.persisted?

      i.save!
    end
  end
end
