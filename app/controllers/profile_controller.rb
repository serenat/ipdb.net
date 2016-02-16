class ProfileController < UserAccessController
  before_action :authorize, :set_unread_count

  def overview
    @user = current_user
    @person = @user.person
    @podcasts = @user.podcasts.uniq
    @companies_people = @person.companies_people.includes(:company)

    respond_to do |format|
      format.html { render 'overview' }
      format.js
    end
  end

  def podcasts
  end

  def companies
  end

  def messages
    @incomings = current_user.incomings.includes(:message).desc
    @published = current_user.sent_messages.desc
    @message = Message.new
    @podcasts = current_user.podcasts.uniq

    respond_to do |format|
      format.html { render 'messages' }
      format.js
    end
  end

  private

  def set_unread_count
    @unread_count = current_user.incomings.where(read: false).count
  end

  def authorize
    current_user || raise(CanCan::AccessDenied, 'Please login or signup to continue.')
  end
end
