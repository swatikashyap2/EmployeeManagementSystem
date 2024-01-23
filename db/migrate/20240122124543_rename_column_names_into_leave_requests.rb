class RenameColumnNamesIntoLeaveRequests < ActiveRecord::Migration[7.0]
  def change
    rename_column :leave_requests, :selected_from, :leave_from
    rename_column :leave_requests, :selected_to, :leave_to
  end
end
