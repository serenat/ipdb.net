class UserPodcastsController < ApplicationController
  

	def index
    @hosts = UserPodcast.all
	end

  def new
    @host = UserPodcast.new
    
  end

  def create
    @host = UserPodcast.new(user_params)

    respond_to do |format|
      if @host.save
        format.html { redirect_to :back ,notice: 'Thank you for submiting your connection. It is currently being proccesed. We will notify you when your podcast is live.' }
        format.json { render action: 'show', status: :created, location: @podcast }
        #PodcastMailer.approval_email(@host).deliver
        if current_user.nil?
        else
          #PodcastMailer.processing_email(current_user, @host).deliver
      end
      else
        format.html { render action: 'new' }
        format.json { render json: @host.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
  end  

  
  def user_params
   	params.require(:user_podcast).permit(:podcast_id, :user_id, :position)
  end
end