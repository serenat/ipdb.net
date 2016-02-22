class PopulateOauthOnUser < ActiveRecord::Migration
  def up
    Identity.find_each do |i|
      i.user.update_columns(
        provider:    i.provider,
        uid:         i.uid,
        oauth_token: i.oauth_token
      )
    end
  end

  def down
  end
end
