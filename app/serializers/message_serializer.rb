class MessageSerializer < ActiveModel::Serializer
  attributes :subject, :body
  has_one :sender
  has_one :podcast
end
