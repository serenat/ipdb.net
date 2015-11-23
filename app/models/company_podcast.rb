class CompanyPodcast < ActiveRecord::Base
  belongs_to :company
  belongs_to :podcast
  validates :podcast, :company, presence: true
  validates :podcast, uniqueness: {scope: :company}
  scope :approved, -> { where(approved: true) }
end
