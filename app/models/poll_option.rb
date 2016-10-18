class PollOption < ApplicationRecord
  belongs_to :poll

  validates :poll, presence: true
  validates :value, presence: true
  validates :position, presence: true
end
