class DropIdentities < ActiveRecord::Migration
  def up
    drop_table :identities
  end

  def down
    create_table :identities do |t|
      t.references :user, index: true, foreign_key: true
      t.string :provider
      t.string :uid

      t.timestamps null: false
    end
  end
end
