class InvitationProcessor
  def initialize discussion, emails
    @discussion = discussion
    @emails     = emails
    @errors     = {}
  end

  attr_accessor :discussion, :emails, :errors

  def process
    errors.clear

    emails.all? do |email|
      email      = email.downcase
      invitation = build_invitation email

      unless result = invitation.save
        errors[email] = invitation.errors.full_messages
      end

      result
    end
  end

  def build_invitation email
    user    = User.where('LOWER(email) = ?', email).first
    user_id = user.try(:id) || 0

    discussion.discussion_invitations.new(email: email, user_id: user_id)
  end
end