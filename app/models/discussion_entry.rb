class DiscussionEntry < ApplicationRecord
  belongs_to :discussion
  belongs_to :discussable, polymorphic: true
end
