require 'invitation_processor'

class DiscussionInvitationsController < ApplicationController
  load_and_authorize_resource :discussion, find_by: :token

  def create
    @processor = InvitationProcessor.new @discussion, discussion_invitation_params[:invitees]
    @processor.process

    respond_to do |format|
      format.js
    end
  end

  private

    def discussion_invitation_params
      params.require(:discussions).permit(invitees: [])
    end
end
