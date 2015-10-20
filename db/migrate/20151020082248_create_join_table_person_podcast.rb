class CreateJoinTablePersonPodcast < ActiveRecord::Migration

  class UserPodcast < ActiveRecord::Base
    belongs_to :user
    belongs_to :podcast
  end

  class PersonPodcast < ActiveRecord::Base
    has_one :user
  end

  class User < ActiveRecord::Base
    belongs_to :person
  end

  def up
    create_table :people_podcasts do |t|
      t.references :person
      t.references :podcast
      t.text    :position
      t.boolean :approved, default: false
      t.timestamps null: false
      t.index  [:person_id, :podcast_id]
    end

    UserPodcast.find_each do |user_podcast|
      if user_podcast.user && user_podcast.podcast
        PersonPodcast.create!(
          position: user_podcast.position,
          approved: user_podcast.approved,
          person_id: user_podcast.user.person.id,
          podcast_id: user_podcast.podcast_id,
        )
      end
    end
  end

  def down
    drop_table :people_podcasts
  end
end
