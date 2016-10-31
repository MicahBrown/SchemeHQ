class PollsController < ApplicationController
  load_and_authorize_resource :discussion, find_by: :token
  load_and_authorize_resource through: :discussion, param_method: :poll_params

  def create
    respond_to do |format|
      if @poll.save
        format.html { redirect_to @discussion, notice: "Successfully saved poll!" }
      else
        format.html { redirect_to @discussion, alert: "Unable to save poll." }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @poll.destroy
        format.html { redirect_to @poll.discussion, notice: "Successfully deleted poll!" }
      else
        format.html { redirect_to @poll.discussion, alert: "Unable to delete poll." }
      end
    end
  end

  private

    def poll_params
      params.require(:poll).permit(:title, poll_options_attributes: [:value, :position])
    end
end
