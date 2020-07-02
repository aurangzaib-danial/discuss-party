class TopicPolicy < ApplicationPolicy
  def edit?
    record.owner?(user)
  end

  def vote?
    record.owner?(user)
  end

  alias_method :update?, :edit?

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
