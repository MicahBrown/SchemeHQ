module SchemeEntryVotesHelper
  def vote_link value, entry, existing_vote=nil
    icon_name   = value.positive? ? "thumbs-o-up" : "thumbs-o-down"
    css_classes = value.positive? ? "upvote"      : "downvote"
    http_method = existing_vote   ? :patch        : :post

    if existing_vote && existing_vote.value == value
      css_classes += " voted"
      http_method  = :delete
    end

    link_to icon(icon_name, 0), scheme_entry_votes_path(entry.scheme, entry, scheme_entry_vote: { value: value }),
      method: http_method,
      class:  css_classes
  end
end
