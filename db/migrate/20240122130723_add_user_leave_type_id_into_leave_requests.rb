class AddUserLeaveTypeIdIntoLeaveRequests < ActiveRecord::Migration[7.0]
  def change
    add_column :leave_requests, :user_leave_type_id, :integer, forigin_key: true
  end
end
