class RemoveColumnLeaveTypeIdFromLeaveRequests < ActiveRecord::Migration[7.0]
  def change
    remove_column :leave_requests, :leave_type_id, :integer
    add_column :leave_requests, :user_id, :integer
  end
end
