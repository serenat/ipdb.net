class MessageSerializer < BaseSerializer
  attributes :subject, :body
  has_one :sender
  has_one :podcast
end
