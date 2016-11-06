class DiscussionInvitationsController < ApplicationController
  load_and_authorize_resource :discussion, find_by: :token

  def create
    @discussion.invite(discussion_invitation_params[:invitees])

    respond_to do |format|
      format.js
    end
  end

  private

    def discussion_invitation_params
      params.require(:discussions).permit(invitees: [])
    end
end
