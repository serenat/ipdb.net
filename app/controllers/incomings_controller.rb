class IncomingsController < UserAccessController

  def show
    load_incoming
    @message = @incoming.message
    @unread_count = current_user.incoming_messages.count
    respond_to do |format|
      format.html { render 'messages/show' }
      format.js   {}
    end
  end

  def delete_bunch
    respond_to do |format|
      if incoming_scope.where(id: params[:ids]).delete_all
        format.html { redirect_to(profile_messages_path, notice: 'Messages have been deleted.') }
        format.json { head :no_content }
      else
        format.html { redirect_to(profile_messages_path, alert: 'Something went wrong. Try again or contact administrator.') }
        format.json { head :unprocessable_entity }
      end
    end
  end

  def destroy
    load_incoming
    respond_to do |format|
      if @incoming.destroy
        format.html { redirect_to profile_messages_path }
        format.json { head :no_content }
      else
        format.html { redirect_to :back }
        format.json { head :unprocessable_entity }
      end
    end
  end

  private

  def incoming_params
    params.require(:incoming).permit(:message_id, :user_id, :read)
  end

  def incoming_scope
    current_user.incomings
  end

  def load_incoming
    @incoming = incoming_scope.find(params[:id])
  end
end
