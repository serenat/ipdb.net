class CompaniesController < ApplicationController
  before_action :set_company, only: [:show, :edit, :update]
  authorize_resource

  def index
    @companies = company_scope.page(params[:page])
  end

  def new
    @company = Company.new
  end

  def create
    @company = Company.new(company_params)
    @company.companies_people << CompanyPerson.new(person: current_person, company: @company, owner: true, approved: true)
    respond_to do |format|
      if @company.save
        format.html { redirect_to({action: 'index'}, notice: 'Thank you for submiting your company. It is currently being proccesed. Please allow 1-2 weeks for your company to be verified.')}
      else
        format.html { render action: 'new' }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @company.update(company_params)
        format.html { redirect_to( @company, notice: 'Company successfuly updated.') }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  def show
    @company_person = @company.companies_people.build(person_id: current_user.person_id)
    @podcasts = Podcast.joins(:companies_podcasts).
      where('companies_podcasts.company_id = ? AND companies_podcasts.approved = ?', @company.id, true)
    @people = Person.joins(:companies_people)
      .where('companies_people.company_id = ? AND companies_people.approved = ?', @company.id, true)
      .includes(:user)
  end

  private

  def company_params
    params.require(:company).permit(:name, :city, :state, :country, :image, :url)
  end

  def company_scope
    Company.approved
  end

  def set_company
    @company ||= company_scope.friendly.find(params[:id])
  end
end
