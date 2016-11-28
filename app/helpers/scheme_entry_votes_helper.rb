module SchemeEntryVotesHelper
  def vote_link value, entry, existing_vote=nil
    icon_name    = value.positive? ? "thumbs-o-up" : "thumbs-o-down"
    css_classes  = value.positive? ? "upvote"      : "downvote"

    if existing_vote && existing_vote.value == value
      css_classes += " voted"

      content_tag :span, icon(icon_name, 0), class: css_classes
    else
      link_to icon(icon_name, 0), scheme_entry_votes_path(entry.scheme, entry, scheme_entry_vote: { value: value }),
        method: existing_vote ? :patch : :post,
        class:  css_classes
    end
  end
end
