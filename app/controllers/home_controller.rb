class HomeController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    redirect_to my_path if current_user
  end
end
