class SchemeInvitation < ApplicationRecord
  belongs_to :scheme
  belongs_to :user
  belongs_to :sender, class_name: "User"

  validates :email, presence:   true,
                    uniqueness: { scope: :scheme_id },
                    format:     { with: EMAIL_REGEX, allow_blank: true }

  before_validation { trim_whitespace :email }
  before_validation { downcase :email }

  def responded?
    responded_at?
  end

  def respond boolean
    self.response     = boolean
    self.responded_at = Time.now if response_changed?
    self.save
  end
end
