class Incoming < ActiveRecord::Base
  belongs_to :recipient, class_name: 'User'
  belongs_to :message

  scope :desc, -> { order(created_at: :desc) }
end
