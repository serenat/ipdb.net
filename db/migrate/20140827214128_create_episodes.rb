class CreateEpisodes < ActiveRecord::Migration
  def change
    create_table :episodes do |t|
      t.string :title
      t.string :source
      t.string :url
      t.text :summary
      t.belongs_to :podcast
      t.timestamps
    end
  end
end
