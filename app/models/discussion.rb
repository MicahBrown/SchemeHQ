class Discussion < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_many :polls
  has_many :discussion_entries

  validates :user, presence: true
  validates :title, presence: true

  before_create :generate_token

  def generate_token
    self[:token] = loop do
      token = SecureRandom.urlsafe_base64(8)

      break token unless self.class.exists?(token: token)
    end
  end

  def to_param; token; end
end
