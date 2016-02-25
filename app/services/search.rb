class Search
  attr_reader :params

  def initialize(params)
    @params = params
  end

  def podcasts
    if podcasts?
      Podcast.search(params[:query]).with_people.with_awards.by_score
    else
      Podcast.none
    end
  end

  def people
    if people?
      Person.search(params[:query])
    else
      Person.none
    end
  end

  def companies
    if companies?
      Company.search(params[:query]).approved
    else
      Company.none
    end
  end

  private

  def podcasts?
    all? || params[:type] == 'Podcasts'
  end

  def people?
    all? || params[:type] == 'People'
  end

  def companies?
    all? || params[:type] == 'Companies'
  end

  def all?
    params[:type] == 'All'
  end
end
