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
end
