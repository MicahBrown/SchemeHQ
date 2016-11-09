class DiscussionInvitation < ApplicationRecord
  belongs_to :discussion
  belongs_to :user

  validates :email, presence: true, uniqueness: { scope: :discussion_id }

  before_validation { strip_whitespace :email }

  def strip_whitespace attr_sym
    value = send(attr_sym)
    value = value.strip if value.is_a?(String)
    value
  end
end
