class UserLeaveTypePolicy < ApplicationPolicy
    attr_reader :current_user, :record
    def initialize(current_user, record)
      @current_user = current_user
      @record = record
    end
  
    def index?
      is_admin?
    end
    
    def new?
      is_admin?
    end
  
    def create?
      is_admin?
    end
  
    def edit?
      is_admin?
    end
  
    def update?
     edit?
    end
  
    def destroy?
       is_admin?
    end
  end
  