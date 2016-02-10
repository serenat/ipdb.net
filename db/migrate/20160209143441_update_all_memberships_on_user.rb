class UpdateAllMembershipsOnUser < ActiveRecord::Migration
  def up
    User.update_all(membership: 'basic')
  end

  def down
  end
end
