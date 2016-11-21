class SchemeParticipant < ApplicationRecord
  enum role: { facilitator: 'facilitator', mediator: 'mediator', member: 'member' }

  belongs_to :user
  belongs_to :scheme
end
