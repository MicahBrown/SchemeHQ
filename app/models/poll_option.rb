class PollOption < ApplicationRecord
  belongs_to :poll

  validates :value, presence: true
  validates :position, presence: true
end
