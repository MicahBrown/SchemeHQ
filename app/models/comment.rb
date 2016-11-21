class Comment < ApplicationRecord
  include Schemable

  belongs_to :user
  belongs_to :scheme

  validates :user, presence: true
  validates :scheme, presence: true
  validates :message, presence: true

  before_validation { trim_whitespace :message }
end
