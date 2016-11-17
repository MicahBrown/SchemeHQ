class UsersController < ApplicationController
  load_resource find_by: :public_token

  def show
    render partial: "users/profile", user: @user
  end
end
