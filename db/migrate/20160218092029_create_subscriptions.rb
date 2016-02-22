class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.references :user, index: true
      t.references :plan
      t.timestamp  :start_date
      t.timestamp  :end_date
      t.timestamp  :trial_start
      t.timestamp  :trial_end
      t.string     :status

      t.timestamps null: false
    end
  end
end
