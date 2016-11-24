require 'to_boolean'

class SchemeInvitationResponsesController < ApplicationController
  load_and_authorize_resource :scheme, find_by: :token
  load_and_authorize_resource :scheme_invitation, through: :scheme, id_param: :invitation_id

  def update
    @scheme_invitation.respond(response_params)

    respond_to do |format|
      format.js
    end
  end

  private

    def response_params
      ToBoolean(params[:response])
    end
end
