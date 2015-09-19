class CreateAwards < ActiveRecord::Migration
  def change
    create_table :awards do |t|
      t.string :name
    end
 
    create_table :awards_podcasts, id: false do |t|
      t.belongs_to :award, index: true
      t.belongs_to :podcast, index: true
    end
  end
end
