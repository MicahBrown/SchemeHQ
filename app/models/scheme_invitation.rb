class SchemeInvitation < ApplicationRecord
  belongs_to :scheme
  belongs_to :user
  belongs_to :sender, class_name: "User"

  validates :email, presence:   true,
                    uniqueness: { scope: :scheme_id },
                    format:     { with: EMAIL_REGEX, allow_blank: true }

  before_validation { trim_whitespace :email }
  before_validation { downcase :email }

  scope :responded, -> { where.not(responded_at: nil) }
  scope :unresponded, -> { where(responded_at: nil) }

  def responded?
    responded_at?
  end

  def respond! boolean
    self.response     = boolean
    self.responded_at = Time.now if response_changed?

    SchemeInvitation.transaction do
      if boolean && user && scheme.participants.exclude?(user)
        SchemeParticipant.transaction do
          scheme.scheme_participants.create! user: user
        end
      end

      self.save!
    end
  end

  def unrespond!
    self.response     = nil
    self.responded_at = nil
    self.save!
  end
end
