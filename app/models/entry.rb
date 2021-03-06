class Entry < ApplicationRecord
  belongs_to :scheme
  belongs_to :schemable, polymorphic: true
  has_many :votes, dependent: :destroy
  has_many :favorites, dependent: :destroy

  def tag
    "e#{id}"
  end
end
