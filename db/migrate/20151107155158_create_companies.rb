class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name, null: false
      t.string :city
      t.string :state
      t.string :country
      t.text :url
      t.attachment :image
      t.boolean :approved, default: false, null: false
      t.string :slug, index: true
      t.timestamps null: false
    end
  end
end
