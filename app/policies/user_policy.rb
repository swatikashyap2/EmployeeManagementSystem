class UserPolicy < ApplicationPolicy
  attr_reader :current_user, :record
    def initialize(current_user, record)
      @current_user = current_user
      @record = record
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
    if is_admin?
      User.all
    elsif is_manager?
      record.role.name  == User.employees.first.role.name || record.role.name  == User.manager.first.role.name
    else 
      record.role.name == User.employees.first.role.name
    end
  end

  def update?
   edit?
  end

  def destroy?
    is_admin? 
  end
  

  # def is_admin?
	# 	@current_user.role.name == "Admin" ? true : false
	# end

	# def is_manager?
	# 	@current_user.role.name == "Manager" ? true : false
	# end

	# def is_employee?
	# 	@current_user.role.name == "Employee" ? true : false
	# end

  def scope
    Pundit.policy_scope!(user, record.class)
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope
    end
  end
end
