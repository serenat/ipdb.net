class PopulateAwards < ActiveRecord::Migration

  def change
    Award::NAMES.each do |name|
      Award.create(name: name)
    end
  end
end
