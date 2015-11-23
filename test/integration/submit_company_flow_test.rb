require 'test_helper'

class CompanyCreateFlowTest < ActionDispatch::IntegrationTest

  def setup
  end

  def teardown
    logout(:user)
  end

  # Guest
  test 'as guest i can not see the submit company page' do
    visit new_company_path
    assert page.has_selector? 'div.alert-info', 'Access Denied.'
  end

  # Regular User
  test 'as regular user i can not see the submit company page' do
    login_as users(:regular), scope: :user
    visit new_company_path
    assert page.has_selector? 'div.alert-info', 'Access Denied.'
  end

  # Payed subscriber. Silver, Gold or Platinum
  test 'as payed subscriber i can see the submit company page' do
    [:silver, :gold, :platinum].each do |user|
      login_as users(user), scope: :user
      visit new_company_path

      assert page.has_selector? 'h1', 'New company'

      logout(:user)
    end
  end
end
