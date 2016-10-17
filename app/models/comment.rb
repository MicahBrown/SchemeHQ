class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :discussion

  validates :user, presence: true
  validates :discussion, presence: true
  validates :message, presence: true
end
