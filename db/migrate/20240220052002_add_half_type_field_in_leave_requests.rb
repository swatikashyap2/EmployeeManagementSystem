class AddHalfTypeFieldInLeaveRequests < ActiveRecord::Migration[7.0]
  def change
    add_column :leave_requests, :half_type, :string
  end
end
