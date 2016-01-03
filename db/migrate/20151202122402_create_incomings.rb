class CreateIncomings < ActiveRecord::Migration
  def change
    create_table :incomings do |t|
      t.references :message, index: true
      t.references :recipient, index: true
      t.boolean :read, default: false, null: false

      t.timestamps null: false
    end
    add_foreign_key :incomings, :messages
    add_foreign_key :incomings, :users, column: :recipient_id
  end
end
