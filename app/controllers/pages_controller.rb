class PagesController < ApplicationController
  def home
    @podcasts = Podcast.all.order('created_at DESC').page(params[:page])
    @users= User.all
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
  def awards
    @awards = Podcast.where("awards <> ''" )
  end
  def privacy
  end
end
