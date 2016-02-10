class PopulatePlans < ActiveRecord::Migration
  def up
    Plan.create(name: 'basic', stripe_id: 'IPDbBasic', price: 0, interval: 'month')
    Plan.create(name: 'silver', stripe_id: 'IPDbSilver', price: 13.0, interval: 'month')
  end

  def down
    Plan.delete_all
  end
end
