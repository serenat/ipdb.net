class User::ParameterSanitizer < Devise::ParameterSanitizer

  private

  def account_update
    default_params.permit(:first_name, :last_name, :description, :profile_image,
      :email, :password, :facebook, :twitter, :instagram, :linkedin, :pinterest,
      :password_confirmation, :current_password, :about, :work, :education, :username, :imdb)
  end

  def sign_in
    default_params.permit(:email, :password)
  end

  def sign_up
    default_params.permit(:first_name, :last_name, :name, :description, :profile_image,
      :email, :password, :facebook, :twitter, :instagram, :linkedin, :pinterest,
      :password_confirmation, :current_password, :about, :work, :education, :username, :imdb)
  end
end
