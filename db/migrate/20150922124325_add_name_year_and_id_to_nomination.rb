class AddNameYearAndIdToNomination < ActiveRecord::Migration
  def change
    add_column :nominations, :id, :primary_key
    add_column :nominations, :name, :string
    add_column :nominations, :year, :string
  end
end
