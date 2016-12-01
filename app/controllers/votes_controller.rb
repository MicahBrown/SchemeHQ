class VotesController < ApplicationController
  load_and_authorize_resource :scheme, find_by: :token
  load_resource :scheme_entry, id_param: :entry_id, through: :scheme
  before_action :load_vote
  authorize_resource

  def create
    @vote.save

    respond_to do |format|
      format.html { redirect_to @scheme }
      format.js { render :create }
    end
  end

  def update
    create # do same thing for update
  end

  def destroy
    @vote.destroy

    respond_to do |format|
      format.html { redirect_to @scheme }
      format.js { render :create }
    end
  end

  private
    def vote_params
      params.require(:vote).permit(:value)
    end

    def load_vote
      return unless @scheme_entry
      @vote   = @scheme_entry.votes.detect {|sev| sev.user_id == current_user.id }
      @vote ||= @scheme_entry.votes.build(user: current_user)
      @vote.assign_attributes(vote_params)
      @vote
    end
end
