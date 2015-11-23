class CompaniesPeopleController < ApplicationController
  before_action :set_company, :set_company_person
  authorize_resource

  def create
    respond_to do |format|
      if @company_person.save
        format.html { redirect_to(company_url(@company), notice: 'Thank you for submiting your connection. It is currently being proccesed. Please allow 1-2 weeks for your connections to be verified.')}
      else
        format.html { redirect_to(company_url(@company), notice: 'Something went wrong. Try again or contact administrator')}
      end
    end
  end

  private

  def set_company
    @company = Company.friendly.find(params[:company_id])
  end

  def set_company_person
    @company_person = @company.companies_people.build(person_id: current_user.person_id)
  end
end
