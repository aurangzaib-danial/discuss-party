class TagPolicy < ApplicationPolicy
  def index?
    user.staff?
  end

  def destroy?
    user.admin?
  end

  %i[new? create? update? edit?].each do |action|
    alias_method action, :index?
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end

end
