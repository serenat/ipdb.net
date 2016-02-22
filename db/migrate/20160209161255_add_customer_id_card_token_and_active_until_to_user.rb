class AddCustomerIdCardTokenAndActiveUntilToUser < ActiveRecord::Migration
  def change
    add_column :users, :customer_id, :string
    add_column :users, :card_token, :string
    add_column :users, :active_until, :timestamp
  end
end
