class MessagesController < UserAccessController

  def create
    @message = current_user.sent_messages.build(message_params)
    authorize! :create, @message
    respond_to do |format|
      if @message.save
        @message.podcast.followers.each do |follower|
          follower.incomings.create(message_id: @message.id)
        end
        format.html { redirect_to @message, notice: 'Message has been sent.' }
        format.json { head :no_content }
      else
        format.html { render action: "new" }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @message = current_user.sent_messages.find(params[:id])
    authorize! :read, @message
    @unread_count = current_user.incoming_messages.count
    respond_to do |format|
      format.html { render 'show' }
      format.js   {}
    end
  end

  private

  def message_params
    params.require(:message).permit(:podcast_id, :subject, :body)
  end
end
