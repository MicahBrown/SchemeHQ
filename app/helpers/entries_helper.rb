module EntriesHelper
  def entry_list entries, show_prev_link: false, show_next_link: true, show_list_end: false
    if entries.present?
      items = []

      if show_prev_link && prev_link = link_to_previous_page(entries, "Load previous entries")
        items.push content_tag(:li, prev_link, class: 'entry-li prev-entries')
      end

      entries.map do |entry|
        items.push content_tag(:li, render(entry), class: 'entry-li')
      end

      if show_next_link && next_link = link_to_next_page(entries, "Load next #{Kaminari.config.default_per_page} entries")
        items.push content_tag :li, next_link, class: 'entry-li next-entries'
      elsif show_list_end
        list_end = content_tag(:small, "No more entries to load", class: 'secondary-text')
        items.push content_tag :li, list_end, class: 'entry-li'
      end

      items.inject(:+)
    else
      content_tag(:li, "No scheme entries have been made yet.", class: "entry-li empty")
    end
  end

  def entry_actions entry, left_links, right_links
    right_links = schemable_actions entry.schemable if right_links.nil?
    left_links  = render('entries/vote_links', entry: entry) +
                  render('entries/favorite_link', entry: entry) if left_links.nil?

    links = []
    links.push content_tag(:div, left_links,  class: 'actions-left')  if left_links.present?
    links.push content_tag(:div, right_links, class: 'actions-right') if right_links.present?
    links.inject(:+)
  end

  def entry_content entry, options={}
    schemable = entry.schemable

    case schemable
    when Comment then
      markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML.new(hard_wrap: true))
      markdown.render(schemable.message).html_safe
      # simple_format(schemable.message)
    when Poll    then
      poll_content = options[:poll_vote] != false &&
                     can_vote?(schemable, current_user) ?
                        'poll_response_form' :
                        'poll_display'

      render "polls/#{poll_content}", poll: schemable
    end
  end

  def entry_details entry
    schemable = entry.schemable

    content_tag(:b, schemable_author(schemable)) + timestamp(schemable)
  end

  def loading_prev?
    params[:load_dir] == 'previous'
  end
end