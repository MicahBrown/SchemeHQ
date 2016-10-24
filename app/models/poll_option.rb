class PollOption < ApplicationRecord
  belongs_to :poll
  has_many :poll_responses

  validates :value, presence: true
  validates :position, presence: true
end
