require 'nokogiri'
require 'open-uri'
require 'httparty'

class PodcastsController < UserAccessController
  before_action :set_podcast, except: [:index, :new, :create, :autocomplete_podcast_name]
  autocomplete :podcast, :name, full: true

  def index
    if category_present_and_correct?
      @podcasts = Podcast.filtered_by_category(params[:category])
        .with_people
        .with_awards
        .by_score
        .try(:page, params[:page])
      @paginate = @podcasts
    else
      @podcasts = Podcast.with_people
        .with_awards
        .by_score
        .page(params[:page])
      @paginate = @podcasts
    end
    @comments = Comment.all
  end

  def show
    @podcast = PodcastDecorator.new(@podcast)
    @episodes = @podcast.episodes_as_json
    @message = @podcast.messages.build

    if current_user
      @user = ActiveModel::SerializableResource.new(current_user).as_json
      @user[:host] = Relations.new(current_user, @podcast).kind_of_host?
    end

    add_to_recently_viewed_podcasts @podcast.id
    @recently_viewed_podcasts = Podcast.where(id: session[:recently_viewed_podcasts])
  end

  def new
    @podcast = Podcast.new
  end

  def edit
  end

  def create
    @podcast = Podcast.new(podcast_params)
    if current_user
      @podcast.people_podcasts.build(person: current_user.person, position: 'Host')
    end

    respond_to do |format|
      if @podcast.save
        format.html { redirect_to(podcasts_path, notice: 'Thank you for submiting your podcast. It is currently being proccesed. We will notify you when your podcast is live.') }
        format.json { render action: 'show', status: :created, location: @podcast }
        PodcastMailer.approval_email(@podcast).deliver_later
        if current_user
          PodcastMailer.processing_email(current_user, @podcast).deliver_later
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
        format.html { redirect_to(@podcast, notice: 'Podcast was successfully updated.') }
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
    current_user.follow(@podcast)
    respond_to do |format|
      format.html { redirect_to :back }
      format.json { head :no_content }
    end
  end

  def unfollow
    current_user.stop_following(@podcast)
    respond_to do |format|
      format.html { redirect_to :back }
      format.json { head :no_content }
    end
  end

  def ppff
    @podcast.increment!(:ppff)
    redirect_to :back
  end

  def upvote
    @podcast.liked_by current_user
    redirect_to :back
  end

  def host
  end

  def count
    CollectStatJob.perform_later @podcast.id, params[:event], request.remote_ip
    head :ok
  end

  private

  def set_podcast
    @podcast = Podcast.friendly.find(params[:id])
  end

  def podcast_params
    if current_user.nil? || current_user.basic?
      params.require(:podcast).permit(:name, :description, :image, :feed_url, :video,
        :explicit, :category, :start_date)
    else
      # Only Sliver, Gold or Platinum users can create/update episodes count
      params.require(:podcast).permit(:name, :description, :image, :feed_url, :video,
        :explicit, :category, :start_date, :episodes_count)
    end
  end

  def get_rss(url)
    rss = Feedjira::Feed.fetch_and_parse(url)
    rss = nil if rss.kind_of? Fixnum
    rss
  end

  def add_to_recently_viewed_podcasts(id)
    session[:recently_viewed_podcasts] ||= []
    session[:recently_viewed_podcasts].unshift(id) unless session[:recently_viewed_podcasts].include?(id)
    session[:recently_viewed_podcasts] = session[:recently_viewed_podcasts][0, 5]
  end

  def category_present_and_correct?
    params[:category].present? && PodcastGenresList::FLAT_LIST.include?(params[:category])
  end
end
