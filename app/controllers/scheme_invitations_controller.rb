require 'invitation_processor'

class SchemeInvitationsController < ApplicationController
  load_and_authorize_resource :scheme, find_by: :token

  def create
    @processor = InvitationProcessor.new @scheme, scheme_invitation_params[:invitees], current_user
    @processor.process

    respond_to do |format|
      format.js
    end
  end

  private

    def scheme_invitation_params
      params.require(:scheme).permit(invitees: [])
    end
end
