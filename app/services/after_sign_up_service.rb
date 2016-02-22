class AfterSignUpService
  attr_reader :user

  def initialize(user = User.new)
    @user = user
  end

  def run
    if valid_and_persisted_user?
      unless user.without_plan?
        UserMailer.welcome_email(user).deliver_later
      end
    end
  end

  def valid_and_persisted_user?
    user.valid? && user.persisted?
  end
end