require 'test_helper'

class CompanyPodcastTest < ActiveSupport::TestCase
  should belong_to(:company)
  should belong_to(:podcast)
  should validate_presence_of(:podcast)
  should validate_presence_of(:company)
  should validate_uniqueness_of(:podcast).scoped_to(:company_id)
end
