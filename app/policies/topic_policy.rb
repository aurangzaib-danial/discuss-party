class TopicPolicy < ApplicationPolicy
  def edit?
    record.owner?(user)
  end

  def vote?
    edit?
  end

  alias_method :update?, :edit?
  alias_method :sharing?, :edit?

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
