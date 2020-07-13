class CommentPolicy < ApplicationPolicy
  def destroy?
    record.commentator?(user) || record.topic_creator?(user)
  end
  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
