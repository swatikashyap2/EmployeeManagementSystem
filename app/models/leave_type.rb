class LeaveType < ApplicationRecord
    has_many :user_leave_types
    has_many :users, through: :user_leave_types
end
