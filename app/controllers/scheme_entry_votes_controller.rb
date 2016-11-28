class SchemeEntryVotesController < ApplicationController
  load_and_authorize_resource :scheme, find_by: :token
  load_resource :scheme_entry, id_param: :entry_id, through: :scheme
  before_action :load_scheme_entry_vote
  authorize_resource

  def create
    @scheme_entry_vote.save

    respond_to do |format|
      format.html { redirect_to @scheme, notice: "vote saved!" }
    end
  end

  def update
    create # do same thing for update
  end

  def destroy
    @scheme_entry_vote.destroy

    respond_to do |format|
      format.html { redirect_to @scheme, notice: "Vote deleted!" }
    end
  end

  private
    def scheme_entry_vote_params
      params.require(:scheme_entry_vote).permit(:value)
    end

    def load_scheme_entry_vote
      return unless @scheme_entry
      @scheme_entry_vote   = @scheme_entry.scheme_entry_votes.detect {|sev| sev.user_id == current_user.id }
      @scheme_entry_vote ||= @scheme_entry.scheme_entry_votes.build(user: current_user)
      @scheme_entry_vote.assign_attributes(scheme_entry_vote_params)
      @scheme_entry_vote
    end
end
