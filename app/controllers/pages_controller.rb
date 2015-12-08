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

  def profile
    @podcasts = Podcast.all
  end

  def ppff
    @podcasts = Podcast.where(:ppff => 1)
  end

  def privacy
  end
end
