class SearchController < UserAccessController
  def show
    if params[:query].present?
      search = Search.new(params)
      @podcasts  = search.podcasts.try(:page, params[:page])
      @people    = search.people
      @companies = search.companies
      @paginate = @podcasts
    else
      @podcasts = Podcast.with_people.with_awards.by_score.page(params[:page])
      @paginate = @podcasts
      @people = Person.none
      @companies = Company.none
    end
  end
end
