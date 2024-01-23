class LeaveRequest < ApplicationRecord
    belongs_to :user
    belongs_to :leave_type
end

