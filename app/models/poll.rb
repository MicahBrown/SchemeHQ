class Poll < ApplicationRecord
  belongs_to :user
  belongs_to :discussion
  has_many :poll_options
end
