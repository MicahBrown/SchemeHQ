module EntriesHelper
  def entry_actions entry, left_links=nil, right_links=nil
    right_links ||= schemable_actions entry.schemable
    left_links  ||= render('entries/vote_links', entry: entry) +
                    render('entries/favorite_link', entry: entry)

    render 'entries/actions', left_links: left_links, right_links: right_links
  end

  def entry_content entry
    schemable = entry.schemable

    case schemable
    when Comment then simple_format(schemable.message)
    when Poll    then
      render "polls/#{can_vote?(schemable, current_user) ? 'poll_response_form' : 'poll_display'}", poll: schemable
    end
  end
end