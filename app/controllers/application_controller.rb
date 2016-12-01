class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  helper_method :current_nicknames
  helper_method :current_votes
  helper_method :current_favorites

  def current_nicknames
    @current_nicknames ||= current_user ? current_user.nicknames : Nickname.none
  end

  def current_votes
    @current_votes ||= current_user ? current_user.votes : Vote.none
  end

  def current_favorites
    @current_favorites ||= current_user ? current_user.favorites : Favorite.none
  end
end
