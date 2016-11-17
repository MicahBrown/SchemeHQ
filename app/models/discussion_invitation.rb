class DiscussionInvitation < ApplicationRecord
  belongs_to :discussion
  belongs_to :user

  validates :email, presence:   true,
                    uniqueness: { scope: :discussion_id },
                    format:     { with: EMAIL_REGEX, allow_blank: true }

  before_validation { trim_whitespace :email }
end
