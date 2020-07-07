class TopicPolicy < ApplicationPolicy
  def edit?
    record.owner?(user)
  end

  def show?
    return true if record.visibility_public? 
    unless user.guest?
      record.owner?(user) || record.viewers.exists?(user: user)
    end
  end

  alias_method :update?, :edit?
  alias_method :sharing?, :edit?
  alias_method :destroy?, :edit?

  alias_method :vote?, :show?
  alias_method :comment?, :show?

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
