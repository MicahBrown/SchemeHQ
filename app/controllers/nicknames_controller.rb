class NicknamesController < ApplicationController
  load_resource :user, find_by: :public_token
  load_and_authorize_resource param_method: :nickname_params

  def create
    @nickname.namee = @user
    @nickname.namer = current_user
    @nickname.save

    respond_to do |format|
      format.js
    end
  end

  def update
    @nickname.update_attributes(nickname_params)

    respond_to do |format|
      format.js { render :create }
    end
  end

  def destroy
    @nickname.destroy

    respond_to do |format|
      format.js { render :create }
    end
  end

  private

    def nickname_params
      params.require(:nickname).permit(:value)
    end
end
