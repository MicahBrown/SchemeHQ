class PollResponsesController < ApplicationController
  load_resource :scheme, find_by: :token
  load_resource :poll, through: :scheme
  load_resource through: :poll, param_method: :poll_response_params

  def create
    authorize! :respond, @scheme

    @poll_response.user = current_user

    respond_to do |format|
      if @poll_response.save
        format.html { redirect_to @scheme, notice: "Successfully saved vote!" }
        format.js
      else
        format.html { redirect_to @scheme, alert: "Unable to save vote." }
        format.js
      end
    end
  end

  private

    def poll_response_params
      params.require(:poll_response).permit(:poll_option_id)
    end
end
