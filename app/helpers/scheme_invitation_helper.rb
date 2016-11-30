module SchemeInvitationHelper
  def clonable_scheme_invitation
    render SchemeInvitation.new(email: "{ email }")
  end

  def invitation_response_label invitation
    css_class  = 'label hollow '
    status     = nil

    if invitation.response?
      css_class += 'success'
      status     = icon('check-circle-o', 'Accepted')
    else
      css_class += 'alert'
      status     = icon('times-circle-o', 'Declined')
    end

    content_tag :span, status, class: css_class
  end

  def invitation_response_form invite, response_value=true
    button_to scheme_invitation_response_path(invite.scheme, invite),
      method:     :put,
      form_class: "invitation-response-form",
      params:     { response: response_value },
      data:       { disable_with: "Please wait..." },
      class:      "button tiny no-margin#{' alert' unless response_value}" do
      response_value ? icon("check-circle-o", "Accept") : icon("times-circle-o", "Decline")
    end
  end
end