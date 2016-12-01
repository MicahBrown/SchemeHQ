module VotesHelper
  def vote_link value, entry, existing_vote, reload_votes=false
    icon_name   = value.positive? ? "thumbs-o-up" : "thumbs-o-down"
    css_classes = value.positive? ? "upvote"      : "downvote"
    http_method = existing_vote   ? :patch        : :post
    vote_count  = entry.votes(reload_votes).select {|vote| vote.value == value }.size

    if existing_vote && existing_vote.value == value
      css_classes += " voted"
      http_method  = :delete
    end

    button_to scheme_entry_votes_path(entry.scheme, entry),
      params:     { vote: { value: value } },
      method:     http_method,
      form_class: "vote-form",
      class:      css_classes do
      icon(icon_name, vote_count)
    end
  end
end
