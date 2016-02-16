class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def facebook
    generated_password = Devise.friendly_token.first(8)
    @user = User.from_oauth(request.env['omniauth.auth'], generated_password)
    respond_to do |format|
      if @user.persisted?
        sign_in @user
        format.html { redirect_to select_plan_path, notice: 'Please select your plan to finish registration.' }
        UserMailer.welcome_from_oauth(@user, generated_password).deliver_later
        # Run worker to update profile image
      else
        format.html { redirect_to root_path, alert: @user.errors.full_messages.join('. ')}
      end
    end
  end
end
