class Plan < ActiveRecord::Base

  def self.basic
    Plan.where(name: 'basic').first
  end

  def basic?
    name == 'basic'
  end

  def self.silver
    Plan.where(name: 'silver').first
  end

  def silver?
    name == 'silver'
  end
end
