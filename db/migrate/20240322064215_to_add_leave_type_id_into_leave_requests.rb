class ToAddLeaveTypeIdIntoLeaveRequests < ActiveRecord::Migration[7.0]
  def change
    add_column :leave_requests, :leave_type_id, :integer
  end
end
