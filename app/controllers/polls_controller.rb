class PollsController < ApplicationController
  load_and_authorize_resource :scheme, find_by: :token
  load_and_authorize_resource through: :scheme, param_method: :poll_params

  def create
    respond_to do |format|
      if @poll.save
        format.html { redirect_to @scheme, notice: "Successfully saved poll!" }
      else
        format.html { redirect_to @scheme, alert: "Unable to save poll." }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @poll.destroy
        format.html { redirect_to @poll.scheme, notice: "Successfully deleted poll!" }
      else
        format.html { redirect_to @poll.scheme, alert: "Unable to delete poll." }
      end
    end
  end

  private

    def poll_params
      params.require(:poll).permit(:title, poll_options_attributes: [:value, :position])
    end
end
