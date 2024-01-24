class LeaveTypePolicy < ApplicationPolicy
    attr_reader :current_user, :record
    def initialize(current_user, record)
      @current_user = current_user
      @record = record
  end


  def index?
      is_admin?
  end
  
  def new?
      false
  end

  def create?
    false
  end

  def edit?
    false
  end

  def update?
    false
  end

  def destroy?
    false
  end
end
