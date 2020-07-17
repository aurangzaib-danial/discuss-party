class ReportPolicy < ApplicationPolicy
  def create?(topic)
    topic.public_and_not_owned_by?(user)
  end
  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
