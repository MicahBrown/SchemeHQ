require 'to_boolean'

class InvitationResponsesController < ApplicationController
  load_and_authorize_resource :scheme, find_by: :token
  load_and_authorize_resource :invitation, through: :scheme

  def update
    @invitation.respond!(response_params)

    respond_to do |format|
      format.js
    end
  end

  private

    def response_params
      ToBoolean(params[:response])
    end
end
