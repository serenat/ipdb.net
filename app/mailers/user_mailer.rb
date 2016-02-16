class UserMailer < ActionMailer::Base
  default from: "IPDb <info@ipdb.net>"

  def welcome_email(user)
    @person = user.person
    @plan = Plan.find_by!(name: user.membership)
    attachments.inline['ipdb-logo.png'] = File.read(
      File.join(Rails.root,'app','assets','images','ipdb-logo.png'))
    mail(to: user.email, subject: 'Welcome to IPDb.')
  end

  def welcome_from_oauth(user, password)
    @user = user
    @person = user.person
    @password = password
    attachments.inline['ipdb-logo.png'] = File.read(
      File.join(Rails.root,'app','assets','images','ipdb-logo.png'))
    mail(to: user.email, subject: 'Welcome to IPDb.')
  end
end
