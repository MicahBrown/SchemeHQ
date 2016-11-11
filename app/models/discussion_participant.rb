class DiscussionParticipant < ApplicationRecord
  enum role: { facilitator: 'facilitator', mediator: 'mediator', player: 'player' }

  belongs_to :user
  belongs_to :discussion
end
