module EntriesHelper
  def entry_actions entry, left_links=nil, right_links=nil
    right_links ||= schemable_actions entry.schemable
    left_links  ||= render('entries/vote_links', entry: entry) +
                    render('entries/favorite_link', entry: entry)

    render 'entries/actions', left_links: left_links, right_links: right_links
  end
end