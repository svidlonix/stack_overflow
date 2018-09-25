class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, :all # permissions for every user, even if not logged in
    if user.present?  # additional permissions for logged in users (they can manage their posts)
      if user.admin?  # additional permissions for administrators
        admin
      elsif user.manager?
        manager
      else
        visitor(user)
      end
    end
  end

  private

  def admin
    can :manage, [Answer, Comment, Question]
  end

  def manager
    can %i[update destroy], [Answer, Comment, Question]
  end

  def visitor(user)
    can :create, [Answer, Comment, Question, Vote]
    can :destroy, Comment, commenter: user
    can :destroy, Vote, voter: user
    can %i[edit update destroy], [Answer, Question], owner: user
  end
end
