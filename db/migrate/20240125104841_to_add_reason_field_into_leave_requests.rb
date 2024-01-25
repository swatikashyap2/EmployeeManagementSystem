class ToAddReasonFieldIntoLeaveRequests < ActiveRecord::Migration[7.0]
  def change
    add_column :leave_requests, :description, :text 
  end
end
