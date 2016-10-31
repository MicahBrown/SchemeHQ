module CommentsHelper
  def comment_actions comment
    return nil unless current_user
    links = []

    if current_user == comment.user
      links.push link_to("Edit", discussion_comment_path(comment.discussion, comment))
      links.push link_to("Delete", discussion_comment_path(comment.discussion, comment), method: :delete)
    end

    action_links links
  end
end
