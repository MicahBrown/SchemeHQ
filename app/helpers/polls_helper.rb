module PollsHelper
  def link_to_remove_poll_option
    button_tag class: "remove-poll-option button alert", title: "Remove Poll Option" do
      icon("minus-circle", content_tag(:span, 'delete option', class: 'show-for-sr'))
    end
  end

  def link_to_add_poll_option(f)
    fields = f.fields_for(:poll_options, PollOption.new, :child_index => "new_poll_options") do |builder|
      render('polls/poll_option_fields', :fields_for => builder, deletable: true)
    end

    link_to icon("plus-circle", "Add Another Poll Option"), "javascript:void(0);",
      class:    "add-poll-option float-right",
      data:     {
        field_hash: {
          association: 'poll_options',
          content:     fields.gsub("\n", "")
        }.to_json
      }
  end

  def can_vote? poll, user
    return false unless user.is_a?(User)

    poll.poll_responses.pluck(:user_id).exclude?(user.id)
  end

  def vote_display poll_option, vote
    value = poll_option.value
    return value if vote.nil?

    value = icon("check", value) if vote.poll_option_id == poll_option.id
    value
  end
end
