class SchemeInvitation < ApplicationRecord
  belongs_to :scheme
  belongs_to :user

  validates :email, presence:   true,
                    uniqueness: { scope: :scheme_id },
                    format:     { with: EMAIL_REGEX, allow_blank: true }

  before_validation { trim_whitespace :email }
  before_validation { downcase :email }
end
