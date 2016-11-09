class DiscussionInvitation < ApplicationRecord
  belongs_to :discussion
  belongs_to :user

  validates :email, presence: true, uniqueness: { scope: :discussion_id }
end
