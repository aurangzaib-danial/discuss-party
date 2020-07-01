class TopicPolicy < ApplicationPolicy
  def edit?
    owner?
  end

  alias_method :update?, :edit?

  private
  def owner?
    user == record.creator
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
