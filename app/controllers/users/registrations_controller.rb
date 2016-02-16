class Users::RegistrationsController < Devise::RegistrationsController
# before_filter :configure_sign_up_params, only: [:create]
# before_filter :configure_account_update_params, only: [:update]
  before_filter :check_membership, only: [:select_plan, :select_silver, :finish]

  # GET /resource/sign_up
  def new
    @plan = Plan.find_by!(name: params[:plan])
    self.build_resource({})
    unless User.find_by(person_id: params[:person_id])
      @person_id = params[:person_id]
    end
    self.resource.build_person
  end

  # POST /resource
  def create
    @plan = Plan.find_by(name: params[:user][:membership])
    @person_id = params[:user][:person_id]

    super

    if resource.without_plan?
      set_flash_message :notice, :signed_up_but_without_plan if is_flashing_format?
    end

    AfterSignUpService.new(resource).run
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  def select_plan
    @basic = Plan.find_by!(name: 'basic')
    @silver = Plan.find_by!(name: 'silver')
  end

  def finish
    plan = Plan.find_by!(name: params[:plan])
    case plan.name
    when 'basic'
      current_user.select_basic_plan
    when 'silver'
      current_user.select_silver_plan(params[:user][:card_token])
    end
    respond_to do |format|
      format.html { redirect_to root_path(shared: false), notice: 'Your registration flow is completely finished.' }
    end
    UserMailer.welcome_email(current_user).deliver_later
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.for(:sign_up) << :attribute
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.for(:account_update) << :attribute
  # end

  # The path used after sign up.
  def after_sign_up_path_for(resource)
    if resource.without_plan?
      select_plan_path
    else
      root_path(shared: false)
    end
  end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end

  private

  def check_membership
    if user_signed_in?
      if current_user.has_plan?
        redirect_to root_path, notice: 'You already selected the plan.'
      end
    else
      redirect_to root_path, notice: 'You are not signed in.'
    end
  end
end
