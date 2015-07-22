class UserController < ApplicationController
  autocomplete :user, :username, :full => true
	def index
		@users= User.all.order('created_at DESC')
		@podcasts = Podcast.all
	end

  def show
    @user = User.find(params[:id])
    @users= User.all
    @podcasts = @user.podcasts
  end
  
  def follow
    @user = User.find(params[:id])
    current_user.follow(@user)
    redirect_to :back
  end
  
  def user_params
   	params.require(:user).permit(:first_name, :last_name)
  end
end