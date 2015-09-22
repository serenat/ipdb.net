class Nomination < ActiveRecord::Base
  belongs_to :award
  belongs_to :podcast

  def description
    "#{year} #{name}".strip if name.presence
  end
end
