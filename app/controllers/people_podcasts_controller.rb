class PeoplePodcastsController < ApplicationController
  before_action :authorize, :set_podcast

  def new
    @host = PersonPodcast.new
    @people_podcasts = @podcast.people_podcasts.approved
  end

  def create
    if person_podcast_params[:person_id].blank?
      person = Person.create!(person_params)
      params[:person_podcast][:person_id] = person.id
    end
    @host = @podcast.people_podcasts.build(person_podcast_params)
    respond_to do |format|
      if @host.save
        format.html { redirect_to :back, notice: 'Thank you for submiting your connection. It is currently being proccesed. We will notify you when your podcast is live.' }
        format.json { render action: 'show', status: :created, location: @podcast }
        #PodcastMailer.approval_email(@host).deliver
        if current_user
          #PodcastMailer.processing_email(current_user, @host).deliver
        end
      else
        @people_podcasts = @podcast.people_podcasts.approved
        format.html { render action: 'new' }
        format.json { render json: @host.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def authorize
    redirect_to :root unless current_user
  end

  def person_podcast_params
    params.require(:person_podcast).permit(:person_id, :position)
  end

  def person_params
    params.require(:person).permit(:name)
  end

  def set_podcast
    @podcast = Podcast.find(params[:podcast_id])
  end
end
