require 'test_helper'

class PersonTest < ActiveSupport::TestCase
  should have_many(:companies_people).dependent(:destroy)
  should have_many(:companies).through(:companies_people)
end
