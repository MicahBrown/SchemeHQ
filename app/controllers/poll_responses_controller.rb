class PollResponsesController < ApplicationController
  load_resource :discussion, find_by: :token
  load_resource :poll, through: :discussion
  load_resource through: :poll, param_method: :poll_response_params

  def create
    authorize! :respond, @discussion

    @poll_response.user = current_user

    respond_to do |format|
      if @poll_response.save
        format.html { redirect_to @discussion, notice: "Successfully saved vote!" }
      else
        format.html { redirect_to @discussion, alert: "Unable to save vote." }
      end
    end
  end

  private

    def poll_response_params
      params.require(:poll_response).permit(:poll_option_id)
    end
end
