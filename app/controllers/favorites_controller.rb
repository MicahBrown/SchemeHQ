class FavoritesController < ApplicationController
  load_and_authorize_resource :scheme, find_by: :token
  load_resource :scheme_entry, through: :scheme, id_param: :entry_id
  before_action :load_favorite
  authorize_resource

  def create
    @favorite.save

    respond_to do |format|
      format.html { redirect_to @scheme }
      format.js
    end
  end

  def destroy
    @favorite.destroy

    respond_to do |format|
      format.html { redirect_to @scheme }
      format.js { render :create }
    end
  end

  private

    def load_favorite
      return unless @scheme_entry
      @favorite   = @scheme_entry.favorites.detect {|faves| faves.user_id == current_user.id }
      @favorite ||= @scheme_entry.favorites.build(user: current_user)
      @favorite
    end
end
