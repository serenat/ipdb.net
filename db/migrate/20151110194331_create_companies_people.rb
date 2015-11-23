class CreateCompaniesPeople < ActiveRecord::Migration
  def change
    create_table :companies_people do |t|
      t.references :person, index: true, foreign_key: true
      t.references :company, index: true, foreign_key: true
      t.boolean :approved, default: false, null: false
      t.boolean :owner, default: false, null: false
      t.timestamps null: false
    end
  end
end
