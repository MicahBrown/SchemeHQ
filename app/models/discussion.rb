class Discussion < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_many :polls
  has_many :discussion_participants
  has_many :discussion_entries
  has_one  :facilitator, -> { facilitator }, class_name: "DiscussionParticipant" # condition uses the enum scope

  validates :user, presence: true
  validates :title, presence: true

  before_create :generate_token
  after_create :assign_facilitator!

  def generate_token
    self[:token] = loop do
      token = SecureRandom.urlsafe_base64(8)

      break token unless self.class.exists?(token: token)
    end
  end

  def assign_facilitator! new_facilitator = user
    return unless new_facilitator

    if f = facilitator
      f.user = new_facilitator
      f.save!
    else
      create_facilitator! user: new_facilitator
    end
  end

  def to_param; token; end
end
