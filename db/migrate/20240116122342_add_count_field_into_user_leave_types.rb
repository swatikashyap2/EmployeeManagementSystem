class AddCountFieldIntoUserLeaveTypes < ActiveRecord::Migration[7.0]
  def change
    add_column :user_leave_types, :count, :integer
  end
end
