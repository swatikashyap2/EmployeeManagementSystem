class LeaveType < ApplicationRecord
    has_many :user_leave_types, dependent: :destroy
    has_many :users, through: :user_leave_types 

    has_many :leave_requests
end
