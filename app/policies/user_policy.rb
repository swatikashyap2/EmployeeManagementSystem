class UserPolicy < ApplicationPolicy


  def index?
    true
  end
  
  def new?
   true
  end

  def create?
   true
  end

  def edit?
    if user.is_admin?
      User.all
    elsif user.is_employee?
      User.where(id: user.id)
    else user.is_manager?
      User.employees
    end
  end

  def update?
    if user.is_admin?
      User.all
    elsif user.is_employee?
      user
    else user.is_manager?
      User.employees
    end
  end

  def destroy?
    if user.is_admin?
      User.all
    elsif user.is_employee?
      user
    else user.is_manager?
      User.employees
    end
  end

  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
      # scope.all
    # end
  end
end
