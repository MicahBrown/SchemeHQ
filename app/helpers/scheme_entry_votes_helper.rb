module SchemeEntryVotesHelper
  def vote_link value, entry, existing_vote=nil
    icon_name   = value.positive? ? "thumbs-o-up" : "thumbs-o-down"
    css_classes = value.positive? ? "upvote"      : "downvote"
    http_method = existing_vote   ? :patch        : :post
    vote_count  = entry.scheme_entry_votes(true).select {|vote| vote.value == value }.size

    if existing_vote && existing_vote.value == value
      css_classes += " voted"
      http_method  = :delete
    end

    button_to scheme_entry_votes_path(entry.scheme, entry),
      params:     { scheme_entry_vote: { value: value } },
      method:     http_method,
      form_class: "vote-form",
      class:      css_classes do
      icon(icon_name, vote_count)
    end
  end
end
