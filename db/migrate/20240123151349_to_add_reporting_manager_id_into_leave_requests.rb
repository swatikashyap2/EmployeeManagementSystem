class ToAddReportingManagerIdIntoLeaveRequests < ActiveRecord::Migration[7.0]
  def change
    add_column :leave_requests, :reporting_manager_id, :integer, forigin_key: true
  end
end