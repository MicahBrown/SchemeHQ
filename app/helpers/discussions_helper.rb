module DiscussionsHelper
  def discussion_entries discussion
    discussion.discussion_entries.includes(:discussable => :user).map(&:discussable)
  end
end
