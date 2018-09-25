class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, :all
    if user.present?
      if user.admin?
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
