class Poll < ApplicationRecord
  include Discussable

  belongs_to :user
  belongs_to :discussion
  has_many :poll_responses
  has_many :poll_options
    accepts_nested_attributes_for :poll_options

  validates :title, presence: true
  validates :user, presence: true
  validates :discussion, presence: true
end
