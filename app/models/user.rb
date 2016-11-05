class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:google_oauth2]

  has_many :discussions
  has_many :comments
  has_many :polls
  has_many :poll_responses

  before_validation :set_display_name

  def set_display_name
    return true if persisted? || email.blank? || display_name.present?

    self.display_name = self.email
  end

  def add_omniauth(auth, force=false)
    return if provider.present? && uid.present? && !force

    self.uid      = auth.uid
    self.provider = auth.provider
    self.email  ||= auth.info.email
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_initialize do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      # user.name = auth.info.name   # assuming the user model has a name
      # user.image = auth.info.image # assuming the user model has an image
    end
  end
end
