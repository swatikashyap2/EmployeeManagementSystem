class AddNewColumnsIntoLeaveRequests < ActiveRecord::Migration[7.0]
  def change
    add_column :leave_requests, :day_type, :string
    add_column :leave_requests, :time_from, :time
    add_column :leave_requests, :time_to, :time
    add_column :leave_requests, :approve, :boolean, default: false 
  end
end
