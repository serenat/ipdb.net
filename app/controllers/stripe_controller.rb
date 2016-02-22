class StripeController < ApplicationController
  protect_from_forgery except: :webhook

  def webhook
    event_json = JSON.parse(request.body.read)
    # Verify the event by fetching it from Stripe
    event = Stripe::Event.retrieve(event_json["id"])

    case event.type
      when "invoice.payment_succeeded" #renew subscription
        user = User.find_by(customer_id: event.data.object.customer)
        user.current_subscription.sync
    end
    respond_to do |format|
      format.json { head :ok }
    end
  end
end
