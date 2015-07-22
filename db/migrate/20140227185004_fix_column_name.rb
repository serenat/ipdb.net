class FixColumnName < ActiveRecord::Migration
  def change
  	rename_column :podcasts, :Name, :name
  end
end
