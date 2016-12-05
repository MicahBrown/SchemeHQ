class UsersController < ApplicationController
  load_resource find_by: :public_token

  def show
    render partial: "users/profile", locals: { user: @user }
  end
end
