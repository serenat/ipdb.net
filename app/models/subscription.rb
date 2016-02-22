class Subscription < ActiveRecord::Base
  belongs_to :plan
  belongs_to :user

  validates :user, :plan, :start_date, :end_date, presence: true

  def sync
    customer = retrieve_stripe_customer
    subscription = retrieve_subscription(customer)
    update_from_event(subscription)
    update_user
  end

  def upgrade
    customer = retrieve_stripe_customer
    subscription = retrieve_subscription(customer)
    return if subscription.plan.id == Plan.silver.stripe_id

    if user.allowed_to_silver_trial?
      response = customer.update_subscription(plan: Plan.silver.stripe_id)
    else
      response = customer.update_subscription(plan: Plan.silver.stripe_id, trial_end: 'now')
    end
    update_from_event(response)
    update_user
  end

  def downgrade
    customer = retrieve_stripe_customer
    subscription = retrieve_subscription(customer)
    return if subscription.plan.id == Plan.basic.stripe_id

    response = customer.update_subscription(plan: Plan.basic.stripe_id)
    update_from_event(response)
    update_user
  end

  def create(card_token)
    return if user.customer_id
    user.membership = Plan.silver.name
    user.card_token = card_token
    user.create_stripe_customer
    user.save!
    sync
  end

  def retrieve_stripe_customer
    Stripe::Customer.retrieve(user.customer_id)
  end

  def retrieve_subscription(customer)
    customer.subscriptions.retrieve(customer.subscriptions.data[0].id)
  end

  def update_from_event(subscription)
    self.status      = subscription.status
    self.start_date  = to_date_time(subscription.current_period_start)
    self.end_date    = to_date_time(subscription.current_period_end)
    self.trial_start = to_date_time(subscription.trial_start)
    self.trial_end   = to_date_time(subscription.trial_end)
    self.plan        = Plan.find_by(stripe_id: subscription.plan.id)
    self.save!
  end

  def update_user
    user.active_until = end_date
    user.membership = plan.name
    user.save!
  end

  def to_date_time(digits)
    Time.at(digits)
  rescue TypeError
    nil
  end

end
