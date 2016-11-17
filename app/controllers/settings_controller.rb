class SettingsController < ApplicationController
  def edit
  end

  def update
    respond_to do |format|
      if current_user.update_attributes(user_params)
        format.html { redirect_to settings_path, notice: "Successfully updated settings!" }
      else
        format.html { render :edit }
      end
    end
  end

  private

    def user_params
      params.require(:user).permit(:display_name)
    end
end
