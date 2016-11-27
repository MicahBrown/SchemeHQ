module SchemesHelper
  def scheme_entries scheme
    scheme.scheme_entries.order('id DESC').includes(:schemable => :user)
  end

  def schemable_author schemable
    user      = schemable.user
    icon_name = case schemable
                when Comment then 'comment'
                when Poll    then 'bar-chart'
                end

    user_link user, icon_name
  end

  def schemable_actions schemable
    case schemable
    when Comment then comment_actions(schemable)
    when Poll    then poll_actions(schemable)
    end
  end

  def clonable_scheme_invitation
    SchemeInvitation.new(email: "{ email }")
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
