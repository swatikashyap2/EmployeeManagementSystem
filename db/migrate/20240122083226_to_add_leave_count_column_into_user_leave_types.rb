class ToAddLeaveCountColumnIntoUserLeaveTypes < ActiveRecord::Migration[7.0]
  def change
    add_column :user_leave_types, :leave_count, :integer
  end
end
