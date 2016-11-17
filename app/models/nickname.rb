class Nickname < ApplicationRecord
  belongs_to :namer, class_name: "User"
  belongs_to :namee, class_name: "User"
end
