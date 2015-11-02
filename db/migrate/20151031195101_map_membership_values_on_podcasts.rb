class MapMembershipValuesOnPodcasts < ActiveRecord::Migration
  LOOKUP = {
    'PodcasterBasic' => 'Silver',
    'Podcast Fan Plus' => 'Gold',
    'PodcasterPRO' => 'Platinum'
  }
  def up
    User.where("membership <> ''").find_each do |user|
      user.membership = LOOKUP[user.membership]
      user.save!
    end
  end

  def down
    User.where("membership <> ''").find_each do |user|
      user.membership = LOOKUP.key(user.membership)
      user.save!
    end
  end
end
