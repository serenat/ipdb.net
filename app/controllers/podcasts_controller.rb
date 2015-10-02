require 'nokogiri'
require 'open-uri'
require 'httparty'

class PodcastsController < ApplicationController
  before_action :set_podcast, only: [:show, :edit, :update, :destroy]
  autocomplete :podcast, :name, :full => true

  def index
    if params[:search].present?
      @podcasts = Podcast.search(params[:search])
      @usersearch = User.search(params[:search])
      @paginate = Kaminari.paginate_array(@podcasts).page(params[:page])
    else
      @podcasts = Podcast.with_awards.order('created_at DESC').page(params[:page]).per(25)
      @paginate = @podcasts
      @usersearch = User.none
    end
    @users= User.all
    @comments = Comment.all
  end

  def show
    doc = Nokogiri::HTML(open(@podcast.episodes_url))
    @itunes = doc.at_css('body')
    @episodesdata = doc.css('tr.podcast-episode')
    @feed = get_rss(@podcast.episodes_url)
    #@podcast = Podcast.find(params[:id])
    #@commentable = @podcast
    #@comments = @commentable.comments
    #@comment = Comment.new
    #@data = Rate.all
    response = HTTParty.get('http://itunes.apple.com/rss/customerreviews/id=' + @podcast.itunes_id.to_s + '/json')
    @id = JSON.parse(response)
    add_to_recently_viewed_podcasts @podcast.id
    @recently_viewed_podcasts = Podcast.where(id: session[:recently_viewed_podcasts])
  end

  def add_to_recently_viewed_podcasts(id)
    session[:recently_viewed_podcasts] ||= []
    session[:recently_viewed_podcasts].unshift(id) unless session[:recently_viewed_podcasts].include?(id)
    session[:recently_viewed_podcasts] = session[:recently_viewed_podcasts][0, 5]
  end

  def new
    @podcast = Podcast.new
  end

  def edit
  end

  def create
    @podcast = Podcast.new(podcast_params)
    if current_user.nil?
      @podcast.users
    else 
      @podcast.users << current_user
    end

    respond_to do |format|
      if @podcast.save
        format.html { redirect_to podcasts_path ,notice: 'Thank you for submiting your podcast. It is currently being proccesed. We will notify you when your podcast is live.' }
        format.json { render action: 'show', status: :created, location: @podcast }
        PodcastMailer.approval_email(@podcast).deliver
        if current_user.nil?
        else
          PodcastMailer.processing_email(current_user, @podcast).deliver
        end
      else
        format.html { render action: 'new' }
        format.json { render json: @podcast.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @podcast.update(podcast_params)
        format.html { redirect_to @podcast, notice: 'Podcast was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @podcast.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @podcast.destroy
    respond_to do |format|
      format.html { redirect_to podcasts_url }
      format.json { head :no_content }
    end
  end

  def follow
    @podcast = Podcast.find(params[:id])
    current_user.follow(@podcast)
    redirect_to :back
  end

  def unfollow
    @podcast = Podcast.find(params[:id])
    current_user.stop_following(@podcast)
    redirect_to :back
  end

  def ppff
    @podcast = Podcast.find(params[:id])
    @podcast.increment!(:ppff)
    redirect_to :back
  end

  def upvote
    @podcast = Podcast.find(params[:id])
    @podcast.liked_by current_user
    redirect_to :back
  end

  def host
    @podcast = Podcast.find(params[:id])
  end


  private

  def set_podcast
    @podcast = Podcast.find(params[:id])
  end

  def podcast_params
    params.require(:podcast).permit(:description, :episodes_url, :name, :image, :video)
  end

  def get_rss(url)
    Feedjira::Feed.fetch_and_parse(url)
  rescue StandardError
  end
end
