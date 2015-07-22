class PodcastMailer < ActionMailer::Base
  default from: "info@ipdb.net"

  def approval_email(podcast)
  	@podcast = podcast
  	mail(to: [['serena@ipdb.net'],['brooke@ipdb.net'],['josiah@ipdb.net']], subject: 'Podcast needs approval')
  end

  def processing_email(user, podcast)
  	@user = user
  	@podcast = podcast
  	mail(to: @user.email, subject: 'Your Podcast is currently being proccesed')
  end
end
