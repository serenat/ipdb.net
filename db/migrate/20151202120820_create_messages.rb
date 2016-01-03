class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.references :sender, index: true
      t.references :podcast, index: true
      t.string :subject
      t.text :body

      t.timestamps null: false
    end
    add_foreign_key :messages, :users, column: :sender_id
    add_foreign_key :messages, :podcasts
  end
end
