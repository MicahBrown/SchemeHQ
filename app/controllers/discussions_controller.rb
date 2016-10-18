class DiscussionsController < ApplicationController
  load_and_authorize_resource param_method: :discussion_params, find_by: :token

  def new
  end

  def create
    respond_to do |format|
      if @discussion.save
        format.html { redirect_to @discussion, notice: "Successfully started discussion!" }
      else
        format.html { render :new }
      end
    end
  end

  def show
  end

  private

    def discussion_params
      params.require(:discussion).permit(:title)
    end
end
