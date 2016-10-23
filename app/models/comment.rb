class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :discussion
  has_many :discussion_entries, as: :discussable

  validates :user, presence: true
  validates :discussion, presence: true
  validates :message, presence: true
end
