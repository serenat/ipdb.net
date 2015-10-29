class PeopleController < ApplicationController
  autocomplete :person, :name, scopes: :uniq_name

  def search
    @people = Person.search(params[:name]).limit(20).includes(:podcasts).includes(:user)
    render json: @people
  end
end
