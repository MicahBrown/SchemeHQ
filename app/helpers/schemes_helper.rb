module SchemesHelper
  def scheme_entries scheme
    scheme.scheme_entries.order('id DESC').includes(:schemable => :user)
  end

  def scheme_entry_timestamp scheme
    value = time_ago_in_words(scheme.updated_at) + " ago"
    value = value.gsub "about ", ""

    content_tag :time, value, title: scheme.updated_at.strftime("%b %-e, %Y %-I:%M %p %Z"), data: { tooltip: true }
  end

  def schemable_author schemable
    user      = schemable.user
    icon_name = case schemable
                when Comment then 'comment'
                when Poll    then 'bar-chart'
                end

    user_link user, icon_name
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
end
