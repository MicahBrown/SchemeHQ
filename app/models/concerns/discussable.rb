require 'active_support/concern'

module Discussable
  extend ActiveSupport::Concern

  included do
    has_one :discussion_entry, as: :discussable, dependent: :destroy

    before_create :link_to_discussion
  end

  def link_to_discussion
    return false unless discussion.is_a?(Discussion)

    build_discussion_entry discussion: discussion
  end
end