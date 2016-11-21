class Poll < ApplicationRecord
  include Schemable

  belongs_to :user
  belongs_to :scheme
  has_many :poll_responses, dependent: :destroy
  has_many :poll_options, dependent: :destroy
    accepts_nested_attributes_for :poll_options

  validates :title, presence: true
  validates :user, presence: true
  validates :scheme, presence: true

  before_validation { trim_whitespace :title }
end
