class CommentsController < ApplicationController
  load_and_authorize_resource :scheme, find_by: :token
  load_and_authorize_resource through: :scheme, param_method: :comment_params

  def create
    respond_to do |format|
      if @comment.save
        format.html { redirect_to @comment.scheme, notice: "Successfully saved comment!" }
      else
        format.html { redirect_to @comment.scheme, alert: "Unable to save comment." }
      end
    end
  end

  def edit
    respond_to do |format|
      format.js
    end
  end

  def update
    @comment.update_attributes(comment_params)

    respond_to do |format|
      format.js
    end
  end

  def destroy
    respond_to do |format|
      if @comment.destroy
        format.html { redirect_to @comment.scheme, notice: "Successfully deleted comment!" }
      else
        format.html { redirect_to @comment.scheme, alert: "Unable to delete comment." }
      end
    end
  end

  private

    def comment_params
      params.require(:comment).permit(:message)
    end
end
