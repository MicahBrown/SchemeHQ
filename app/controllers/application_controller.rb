class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  helper_method :current_nicknames

  def current_nicknames
    @current_nicknames ||= current_user ? current_user.nicknames : Nickname.none
  end
end
