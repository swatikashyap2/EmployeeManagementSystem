class ChangeDataTypeOfLeaveCountColumnIntoUserLeaveTypes < ActiveRecord::Migration[7.0]
    def change
        change_column :user_leave_types, :leave_count, :float
    end
end
