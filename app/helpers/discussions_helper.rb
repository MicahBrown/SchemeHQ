module DiscussionsHelper
  def discussion_entries discussion
    discussion.discussion_entries.order('id DESC').includes(:discussable => :user)
  end

  def discussion_entry_timestamp discussion
    value = time_ago_in_words(discussion.updated_at) + " ago"
    value = value.gsub "about ", ""

    content_tag :time, value, title: discussion.updated_at.strftime("%b %-e, %Y %-I:%M %p %Z"), data: { tooltip: true }
  end

  def discussable_author discussable
    icon_name = case discussable
                when Comment then 'comment'
                when Poll    then 'bar-chart'
                end

    icon(icon_name, discussable.user.display_name, class: 'fa-fw')
  end

  def clonable_discussion_invitation
    DiscussionInvitation.new(email: "{ email }")
  end
end
