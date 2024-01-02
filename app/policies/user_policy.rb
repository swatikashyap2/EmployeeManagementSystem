class UserPolicy < ApplicationPolicy
  attr_reader :current_user, :user
    def initialize(current_user, user)
      @current_user = current_user
      @user = user
    end
  

  def index?
    true
  end
  
  def new?
    is_admin?
  end

  def create?
    is_admin?
  end

  def edit?
    debugger
    if is_admin?
      User.all
    elsif is_manager?
      User.employees || User.manager
    else 
      User.employees
    end
  end

  def update?
    if is_admin?
      User.all
    elsif is_manager?
      User.employees || User.manager
    else 
      User.employees
    end
  end

  def destroy?
    if is_admin?
      true # Admin can destroy any user
    elsif is_manager?
      # Managers can destroy employees based on the conditions specified in the User.employees scope
      User.employees.include?(user)
    else
      false # Employees and other users don't have the permission to destroy users
    end
  end
  

  def is_admin?
		@current_user.role.name == "Admin" ? true : false
	end

	def is_manager?
		@current_user.role.name == "Manager" ? true : false
	end

	def is_employee?
		@current_user.role.name == "Employee" ? true : false
	end

  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
      # scope.all
    # end
    
  end
end
