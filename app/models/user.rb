class User < ApplicationRecord
  DISPLAY_NAME_LIMIT = (4..50).freeze

  has_secure_token :public_token

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:google_oauth2]

  has_many :schemes # created schemes
  has_many :scheme_participants
  has_many :scheme_invitations
  has_many :participated_schemes, through: :scheme_participants, source: :scheme
  has_many :comments
  has_many :polls
  has_many :poll_responses
  has_many :nicknames, foreign_key: :namer_id
  has_many :sent_invitations, class_name: "SchemeInvitation", foreign_key: :sender_id

  validates :display_name, presence: true, length: { in: DISPLAY_NAME_LIMIT, allow_blank: true }

  before_validation :set_display_name
  before_validation { trim_whitespace :display_name }


  def set_display_name
    return true if persisted? || email.blank? || display_name.present?

    self.display_name = self.email[0...DISPLAY_NAME_LIMIT.max]
  end

  def to_param; public_token; end

  def add_omniauth(auth, force=false)
    return if omniauthed? && !force

    self.uid      = auth.uid
    self.provider = auth.provider
    self.email  ||= auth.info.email
  end

  def omniauthed?
    self.provider.present? && self.uid.present?
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_initialize do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      # user.name = auth.info.name   # assuming the user model has a name
      # user.image = auth.info.image # assuming the user model has an image
    end
  end

  def all_invitations
    SchemeInvitation.where(email: self.email)
  end

  protected

    def confirmation_required?
      !omniauthed?
    end
end
