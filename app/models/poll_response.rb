class PollResponse < ApplicationRecord
  belongs_to :user
  belongs_to :poll
  belongs_to :poll_option

  validates :user, :poll, :poll_option, presence: true
end
