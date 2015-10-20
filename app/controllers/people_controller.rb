class PeopleController < ApplicationController
  autocomplete :person, :name, full: true
end
