class AddDocUrlToPeoplePodcasts < ActiveRecord::Migration
  def change
    add_column :people_podcasts, :doc_url, :text
  end
end
