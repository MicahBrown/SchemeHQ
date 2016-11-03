module CommentsHelper
  def comment_actions comment
    return nil unless current_user
    links = []

    if current_user == comment.user
      links.push link_to(icon("pencil", "Edit"), edit_discussion_comment_path(comment.discussion, comment), class: "edit" )
      links.push link_to(icon("trash", "Delete"), discussion_comment_path(comment.discussion, comment), method: :delete, class: "delete", data: { confirm: "Are you sure?" })
    end

    action_links links
  end
end
