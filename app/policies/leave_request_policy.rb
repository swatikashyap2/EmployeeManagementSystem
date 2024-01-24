class LeaveRequestPolicy < ApplicationPolicy
    attr_reader :current_user, :record
    def initialize(current_user, record)
      @current_user = current_user
      @record = record
    end
  
    def index?
      true
    end
    
    def new?
      is_manager? || is_employee?
    end
  
    def create?
      new?
    end
    
    def leave_approve?
        is_admin?
    end

    def leave_reject?
        is_admin?
    end
  end
  