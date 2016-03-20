class ReviewCommentController < UserAccessController
  respond_to :json

  def create
    @comment = review.build_comment(comment_params)
    @comment.user = current_user
    authorize! :create, @comment
    @comment.save
    respond_with @comment, location: nil
  end

  def update
    @comment = review.comment
    authorize! :update, @comment
    @comment.update(comment_params)
    respond_with @comment, json: @comment, location: nil
  end

  def destroy
    @comment = review.comment
    authorize! :destroy, @comment
    @comment.destroy
    respond_with @comment
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def review
    Review.find(params[:review_id])
  end
end
