class DisplayNamesController < ApplicationController
  load_and_authorize_resource :user, find_by: :public_token

  def update
    @user.update_attributes(user_params)

    respond_to do |format|
      format.js
    end
  end

  private

    def user_params
      params.require(:user).permit(:display_name)
    end
end
