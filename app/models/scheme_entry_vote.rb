class SchemeEntryVote < ApplicationRecord
  belongs_to :user
  belongs_to :scheme_entry
end
