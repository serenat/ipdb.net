class CompanyPerson < ActiveRecord::Base
  belongs_to :company
  belongs_to :person
  validates :person, :company, presence: true
  validates :person, uniqueness: {scope: :company}
  validates :owner, uniqueness: { :scope => :company }, if: :owner
end
