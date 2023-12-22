class UserPolicy < ApplicationPolicy
  def index?
    user.is_admin? || user.is_employee? || user.is_manager?
  end
  
  def new?
    user.is_admin? ||  user.is_manager?
  end

  def create?
    user.is_admin? ||  user.is_manager?
  end

  def edit_user?
    user.is_admin? ||  user.is_manager?
  end

  def update?
    user.is_admin? ||  user.is_manager?
  end

  def destroy?
    user.is_admin? ||  user.is_manager?
  end
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
      # scope.all
    # end
  end
end
