class PopulateAwards < ActiveRecord::Migration

  def up
    Award::NAMES.each do |name|
      Award.create(name: name)
    end
  end

  def down
    Award.delete_all
  end
end
