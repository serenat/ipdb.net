module PrettyId
  extend ActiveSupport::Concern

  included do
    extend FriendlyId
    friendly_id :slug_candidates, use: :slugged

    def slug_candidates
      [
        :name,
        [:id, :name]
      ]
    end
  end
end
