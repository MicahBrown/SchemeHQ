class Comment < ApplicationRecord
  include Discussable

  belongs_to :user
  belongs_to :discussion

  validates :user, presence: true
  validates :discussion, presence: true
  validates :message, presence: true
end
