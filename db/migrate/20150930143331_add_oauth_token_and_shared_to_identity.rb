class AddOauthTokenAndSharedToIdentity < ActiveRecord::Migration
  def change
    add_column :identities, :oauth_token, :string
    add_column :identities, :shared, :boolean, default: false
  end
end
