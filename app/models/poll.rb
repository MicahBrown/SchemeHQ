class Poll < ApplicationRecord
  belongs_to :user
  belongs_to :discussion
  has_many :poll_options

  validates :title, presence: true
  validates :user, presence: true
  validates :discussion, presence: true
end
