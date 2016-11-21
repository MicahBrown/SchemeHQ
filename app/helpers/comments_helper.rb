module CommentsHelper
  def comment_actions comment
    return nil unless current_user
    links = []

    if current_user == comment.user
      links.push link_to(icon("pencil", "Edit"), edit_scheme_comment_path(comment.scheme, comment), class: "edit" )
      links.push link_to(icon("trash", "Delete"), scheme_comment_path(comment.scheme, comment), method: :delete, class: "delete", data: { confirm: "Are you sure?" })
    end

    action_links links
  end
end
