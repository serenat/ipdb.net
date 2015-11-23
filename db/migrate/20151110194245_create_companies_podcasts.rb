class CreateCompaniesPodcasts < ActiveRecord::Migration
  def change
    create_table :companies_podcasts do |t|
      t.references :podcast, index: true, foreign_key: true
      t.references :company, index: true, foreign_key: true
      t.boolean :approved, default: false, null: false
      t.timestamps null: false
    end
  end
end
