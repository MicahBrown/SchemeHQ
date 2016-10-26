module DiscussionsHelper
  def discussion_entries discussion
    discussion.discussion_entries.order('id DESC').includes(:discussable => :user)
  end
end
