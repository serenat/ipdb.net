class PagesController < ApplicationController

  def home
    @share = params[:shared] == 'false'
    @resource = User.new
    @resource.build_person
  end

  def dashboard
  end

  def about
  end

  def ppff
    @podcasts = Podcast.where(:ppff => 1)
  end

  def privacy
  end

  def pricing
    @basic = Plan.find_by!(name: 'basic')
    @silver = Plan.find_by!(name: 'silver')
  end
end
