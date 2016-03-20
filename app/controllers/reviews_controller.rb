class ReviewsController < UserAccessController
  respond_to :json

  def index
    @reviews =
      case params[:filter]
      when 'itunes'
        podcast.reviews.where(itunes: true)
      when 'ipdb'
        podcast.reviews.where(itunes: false)
      else
        podcast.reviews
      end
    @reviews = @reviews.order(commented_at: :desc).limit(params[:quantity] || 10)
    respond_with @reviews
  end

  def new
    @review = podcast.reviews.build
    authorize! :create, @review
    head :no_content
  end

  def create
    @review = podcast.reviews.build(review_params)
    authorize! :create, @review
    @review.user = current_user
    @review.save
    respond_with @review, location: nil
  end

  def update
    @review = podcast.reviews.find(params[:id])
    @review.update(review_params)
    respond_with @review, json: @review, location: nil
  end

  def destroy
    @review = podcast.review.find(params[:id])
    @review.destroy
    respond_with @review
  end

  private

  def review_params
    params.require(:review).permit(:title, :rating, :content)
  end

  def podcast
    @podcast ||= Podcast.friendly.find(params[:podcast_id])
  end
end
