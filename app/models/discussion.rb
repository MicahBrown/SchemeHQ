class Discussion < ApplicationRecord
  belongs_to :user
  has_many :comments

  validates :user, presence: true
  validates :title, presence: true
end
