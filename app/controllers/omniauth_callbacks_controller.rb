class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def facebook
    @user = User.find_for_oauth(request.env["omniauth.auth"])
    if @user.persisted?
      sign_in @user
      redirect_to root_path(shared: @user.identity.shared)
      set_flash_message(:notice, :success, kind: 'Facebook') if is_navigational_format?
    else
      session["devise.user_attributes"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end
end
