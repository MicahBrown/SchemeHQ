class Discussion < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_many :polls

  validates :user, presence: true
  validates :title, presence: true
end
