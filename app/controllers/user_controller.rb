class UserController < UserAccessController
  autocomplete :user, :username, :full => true

  def follow
    @user = User.find(params[:id])
    current_user.follow(@user)
    redirect_to :back
  end
end
