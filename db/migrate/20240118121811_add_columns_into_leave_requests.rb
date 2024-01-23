class AddColumnsIntoLeaveRequests < ActiveRecord::Migration[7.0]
  def change
    add_column :leave_requests, :selected_from, :date
    add_column :leave_requests, :selected_to, :date
  end
end
