class ReportPolicy < ApplicationPolicy
  def create?
    if user.staff?
      record.topic.public_and_not_owned_by?(user) && !record.topic.reported_by?(user)
    else
      record.topic.public_and_not_owned_by?(user)
    end
  end
  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
