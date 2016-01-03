require 'test_helper'

class ViewCompanyFlowTest < ActionDispatch::IntegrationTest
  include ActionView::Helpers::NumberHelper

  def setup
    @company = companies(:one)
  end

  def teardown
    logout(:user)
  end

  # Guest
  test 'as guest i can see the companies page' do
    visit companies_path
    assert page.has_selector? 'h1', 'Companies list'
  end

  test 'as guest i can not see the company page' do
    visit company_path(@company)
    assert page.has_selector? 'div.alert-danger', 'Access Denied.'
  end

  # Regular User
  test 'as regular user i can not see the company page' do
    login_as users(:regular), scope: :user
    visit company_path(@company)
    assert page.has_selector? 'div.alert-danger', 'Access Denied.'
  end

  test 'as regular user i can see the companies page' do
    login_as users(:regular), scope: :user
    visit companies_path
    assert page.has_selector? 'h1', 'Companies list'
  end

  # Payed subscriber. Silver, Gold or Platinum
  test 'as payed subscriber i can see the company page' do
    [:silver, :gold, :platinum].each do |user|
      login_as users(user), scope: :user
      visit company_path(@company)

      assert page.has_content? @company.name
      within '.podography' do
        @company.podcasts.each do |podcast|
          assert page.has_content? podcast.name
          assert page.has_content? podcast.description
          assert page.has_content? prettify_score(podcast.score)
        end
      end

      within '.people' do
        @company.people.each do |person|
          assert page.has_content? person.name
        end
      end

      logout(:user)
    end
  end

  test 'as payed subscriber i can see the companies page' do
    [:silver, :gold, :platinum].each do |user|
      login_as users(user), scope: :user
      visit companies_path

      assert page.has_content? 'Listing companies'

      logout(:user)
    end
  end

  private

  def prettify_score(score)
    number_with_delimiter((score * 100000).to_i)
  end
end
