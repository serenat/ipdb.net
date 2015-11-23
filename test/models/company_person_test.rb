require 'test_helper'

class CompanyPersonTest < ActiveSupport::TestCase
  should belong_to(:company)
  should belong_to(:person)
  should validate_presence_of(:person)
  should validate_presence_of(:company)
  should validate_uniqueness_of(:person).scoped_to(:company_id)
end
