class AddCanceledToLeaveRequests < ActiveRecord::Migration[7.0]
  def change
    add_column :leave_requests, :canceled, :boolean
  end
end
