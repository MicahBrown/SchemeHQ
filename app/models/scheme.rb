class Scheme < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_many :polls
  has_many :scheme_participants
  has_many :invitations
  has_many :participants, through: :scheme_participants, source: :user
  has_many :scheme_entries
  has_one  :facilitator, -> { facilitator }, class_name: "SchemeParticipant" # condition uses the enum scope

  validates :user, presence: true
  validates :title, presence: true

  before_create :generate_token
  after_create :assign_facilitator!
  before_validation { trim_whitespace :title }

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

  def invite emails
    emails = emails.select(&:present?)

    return false if emails.blank?

    emails.all? do |email|
      email = email.downcase
      user  = User.where('LOWER(email) = ?', email).first

      invitations.create(email: email, user_id: user.try(:id) || 0)
    end
  end
end
