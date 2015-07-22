class CreateUserPodcasts < ActiveRecord::Migration
def change
    create_table :user_podcasts do |t|
      t.belongs_to :podcast
      t.belongs_to :user
      t.timestamps
    end
  end
end