class ProfileController < ApplicationController
  before_action :authorize, :set_unread_count

  def overview
    @user = current_user
    @person = @user.person
    @people_podcasts = PersonPodcast.sort_by_position(@person.people_podcasts.includes(:podcast))
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
