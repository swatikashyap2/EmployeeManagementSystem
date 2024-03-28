class UserPolicy < ApplicationPolicy
  attr_reader :current_user, :record
  def initialize(current_user, record)
    @current_user = current_user
    @record = record
  end

  def index?
    is_admin? || is_manager?
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
      record.role.name  == "employee" || record.role.name  == "manager"
    else 
      record.role.name == "employee"
    end
  end

  def update?
   edit?
  end

  def destroy?
     is_admin?
  end

  def show?
    true
  end
end
