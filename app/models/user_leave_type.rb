class UserLeaveType < ApplicationRecord
    belongs_to :user, dependent: :destroy
    belongs_to :leave_type, dependent: :destroy
end
