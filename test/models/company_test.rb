require 'test_helper'

class CompanyTest < ActiveSupport::TestCase
  should have_many(:companies_podcasts).dependent(:destroy)
  should have_many(:podcasts).through(:companies_podcasts)
  should have_many(:companies_people).dependent(:destroy)
  should have_many(:people).through(:companies_people)
  should validate_presence_of(:name)
end
