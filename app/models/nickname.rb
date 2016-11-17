class Nickname < ApplicationRecord
  belongs_to :namer, class_name: "User"
  belongs_to :namee, class_name: "User"

  validates :value, presence: true, length: { in: User::DISPLAY_NAME_LIMIT, allow_blank: true }
end
