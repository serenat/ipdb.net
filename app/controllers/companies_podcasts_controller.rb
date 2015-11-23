class CompaniesPodcastsController < ApplicationController
  before_action :set_company
  before_action :set_company_podcast, only: :create
  authorize_resource

  def new
    @company_podcast = CompanyPodcast.new
    @podcasts = current_user.person.host_podcasts.approved.includes(:companies_podcasts)
    @company_podcasts = @company.podcasts
  end

  def create
    respond_to do |format|
      if @company_podcast.save
        format.html { redirect_to({action: 'new'}, notice: 'Thank you for submiting your connection. It is currently being proccesed. Please allow 1-2 weeks for your connections to be verified.')}
        format.json { head :no_content }
      else
        format.html { redirect_to({action: 'new'}, 'Something went wrong. Try again or contact administrator') }
        format.json { head :no_content, status: :unprocessable_entity}
      end
    end
  end

  private

  def company_podcasts_params
    params.require(:company_podcast).permit(:podcast_id)
  end

  def set_company_podcast
    @company_podcast = @company.companies_podcasts.build(company_podcasts_params)
  end

  def set_company
    @company = Company.friendly.find(params[:company_id])
  end
end
