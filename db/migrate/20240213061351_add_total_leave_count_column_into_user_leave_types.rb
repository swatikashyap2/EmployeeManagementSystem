class AddTotalLeaveCountColumnIntoUserLeaveTypes < ActiveRecord::Migration[7.0]
  def change
    add_column :user_leave_types, :total_leave_count, :integer
    remove_column :user_leave_types, :count, :integer
  end
end
