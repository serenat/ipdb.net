class UserController < ApplicationController
  autocomplete :user, :username, :full => true

  def show
    @user = User.find(params[:id])
    @users = User.all
    @people_podcasts = @user.people_podcasts.includes(:podcast)
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
