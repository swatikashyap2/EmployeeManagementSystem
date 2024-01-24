class LeaveRequest < ApplicationRecord
    belongs_to :user
    belongs_to :reporting_manager, class_name: 'User', foreign_key: 'reporting_manager_id', optional: true
    belongs_to :user_leave_type

    before_create :set_default_values

    def set_default_values
      self.reporting_manager_id = User.admin.first.id
      self.approve = nil
    end
end

