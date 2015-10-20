class PeoplePodcastsController < ApplicationController

  def new
    @host = PersonPodcast.new
  end

  def create
    @host = PersonPodcast.new(person_podcast_params)

    respond_to do |format|
      if @host.save
        format.html { redirect_to :back, notice: 'Thank you for submiting your connection. It is currently being proccesed. We will notify you when your podcast is live.' }
        format.json { render action: 'show', status: :created, location: @podcast }
        #PodcastMailer.approval_email(@host).deliver
        if current_user
          #PodcastMailer.processing_email(current_user, @host).deliver
        end
      else
        format.html { render action: 'new' }
        format.json { render json: @host.errors, status: :unprocessable_entity }
      end
    end
  end

  def person_podcast_params
    params.require(:person_podcast).permit(:podcast_id, :person_id, :position)
  end
end
