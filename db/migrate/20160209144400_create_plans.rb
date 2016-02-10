class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.string :name
      t.string :stripe_id
      t.decimal :price, precision: 5, scale: 2
      t.string :interval
    end
  end
end
