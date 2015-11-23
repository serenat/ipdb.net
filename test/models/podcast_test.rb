require 'test_helper'

class PodcastTest < ActiveSupport::TestCase
  should have_many(:people_podcasts).dependent(:destroy)
  should have_many(:people).through(:people_podcasts)
  should have_many(:users).through(:people)
  should have_many(:nominations)
  should have_many(:awards).through(:nominations)
  should have_many(:companies_podcasts).dependent(:destroy)
  should have_many(:companies).through(:companies_podcasts)
  should have_one(:podcast_stat).dependent(:destroy)
  should accept_nested_attributes_for(:nominations).allow_destroy(true)
end
