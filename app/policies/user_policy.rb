class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.moderator?
        scope.where(role: :normal_user).order(:id)
      else
        scope.order(:id)
      end
    end
  end
end
