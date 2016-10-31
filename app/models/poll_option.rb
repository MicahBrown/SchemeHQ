class PollOption < ApplicationRecord
  belongs_to :poll
  has_many :poll_responses, dependent: :destroy

  validates :value, presence: true
  validates :position, presence: true
end
