class SubscriptionsController < UserAccessController
  rescue_from Stripe::StripeError, with: :stripe_error

  def upgrade
    respond_to do |format|
      if Subscription.new(user: current_user).upgrade
        format.html { redirect_to profile_subscription_path, notice: "Your plan has been upgraded to #{Plan.silver.name}" }
        format.json { head :no_content }
      else
        format.html { redirect_to profile_subscription_path, notice: "Your plan can't be upgraded to #{Plan.silver.name}" }
        format.json { head :unprocessable_entity }
      end
    end
  end

  def downgrade
    respond_to do |format|
      if Subscription.new(user: current_user).downgrade
        format.html { redirect_to profile_subscription_path, notice: "Your plan has been downgraded to #{Plan.basic.name}" }
        format.json { head :no_content }
      else
        format.html { redirect_to profile_subscription_path, notice: "Your plan can't be downgraded to #{Plan.basic.name}" }
        format.json { head :unprocessable_entity }
      end
    end
  end

  def create
    card_token = params[:user][:card_token]
    respond_to do |format|
      if Subscription.new(user: current_user).create(card_token)
        format.json { head :no_content }
      else
        format.json { head :unprocessable_entity }
      end
    end
  end

  private

  def stripe_error(e)
    respond_to do |format|
      format.html { redirect_to profile_subscription_path, notice: e.message }
      format.json { render json: e.message, status: :unprocessable_entity }
    end
  end
end
