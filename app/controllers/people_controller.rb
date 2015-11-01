class PeopleController < ApplicationController
  autocomplete :person, :name, scopes: :uniq_name

  def search
    @people = Person.search(params[:name]).limit(20).includes(:podcasts).includes(:user)
    render json: @people
  end

  def show
    @person = Person.find(params[:id])
    @user = @person.user
    @people_podcasts = @person.people_podcasts.fully_approved.includes(:podcast)
  end
end