class LeaveRequest < ApplicationRecord
    belongs_to :user
    belongs_to :reporting_manager, class_name: 'User', foreign_key: 'reporting_manager_id', optional: true
    belongs_to :user_leave_type

    before_create :set_default_values

    validates :user_leave_type_id, presence: true
    validates :leave_from, presence: true
    validates :description, presence: true
    validate :leave_from_before_current_date
    validate :leave_to_before_current_date

    enum :day_type, {half_day: "half_day", full_day: "full_day"}

    def set_default_values
      self.reporting_manager_id = User.admin.first.id
      self.approve = nil
    end

    def leave_from_before_current_date
      if leave_from.present? && leave_from < Date.current
        errors.add(:leave_from, " Enter a valid date you can not select privious date")
      end
    end
    
    def leave_to_before_current_date
      if leave_to.present? && leave_to < Date.current
        errors.add(:leave_to, " Enter a valid date you can not select privious date")
      end
    end


    def check_leave_balance
      if leave_to.present? && user_leave_type.present?
        leave_balance_date = user_leave_type.leave_count.days.to_now.to_date
  
        if leave_to > leave_balance_date
          errors.add(:leave_from, "You cannot select more days than your leave balance.")
        end
      end
    end
end

 