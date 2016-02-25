ActiveAdmin.register Subscription  do
  index do
    column :user
    column :status
    column :start_date
    column :end_date
    column :trial_start
    column :trial_end
  end
end
