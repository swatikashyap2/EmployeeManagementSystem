class Admin::UserPolicy < ApplicationPolicy
    def index?
      user.is_admin? 
    end
    
    def new?
      user.is_admin? 
    end
  
    def create?
      user.is_admin? 
    end
  
    def edit?
      user.is_admin? 
    ends
  
    def update?
      user.is_admin? 
    end
  
    def destroy?
      user.is_admin? 
    end
    class Scope < Scope
      # NOTE: Be explicit about which records you allow access to!
      # def resolve
        # scope.all
      # end
    end
  end
  