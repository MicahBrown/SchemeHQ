class SchemeEntry < ApplicationRecord
  belongs_to :scheme
  belongs_to :schemable, polymorphic: true
end
