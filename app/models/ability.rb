class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities

    if user
      can :manage, User, id: user.id
      can :create, Nickname
      can :manage, Nickname, namer_id: user.id
      can :create, Poll
      can :manage, Poll, user_id: user.id
      can :create, Comment
      can :manage, Comment, user_id: user.id
      can :create, Scheme
      can :manage, Scheme, user_id: user.id
      can :create, Vote
      can :manage, Vote, user_id: user.id
      can :create, Favorite
      can :manage, Favorite, user_id: user.id
      can [:read, :respond], Scheme, private: false
      can :manage, Invitation, sender_id: user.id
      can([:read, :update], Invitation, email: user.email) if user.email.present?
    end
  end
end
