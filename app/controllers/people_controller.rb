class PeopleController < UserAccessController
  autocomplete :person, :name, scopes: :uniq_name

  def search
    @people = Person.search(params[:name]).limit(20).includes(:podcasts).includes(:user)
    render json: @people
  end

  def show
    @person = Person.friendly.find(params[:id])
    @user = @person.user
    @people_podcasts = @person.people_podcasts.fully_approved.includes(:podcast)
    @companies = @person.companies.joins(:companies_people).where('companies_people.approved' => true)
  end
end
