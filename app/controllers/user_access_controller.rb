class UserAccessController < ApplicationController
  before_action :authorize_plan

  protected

  def authorize_plan
    if current_user && current_user.without_plan?
      respond_to do |format|
        format.json { render nothing: true, status: :forbidden }
        format.html { redirect_to select_plan_path, :alert => "You have to select your plan to finish registration." }
      end
    end
  end
end
