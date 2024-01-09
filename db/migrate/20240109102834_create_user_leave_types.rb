class CreateUserLeaveTypes < ActiveRecord::Migration[7.0]
  def change
    create_table :user_leave_types do |t|

      t.timestamps
    end
  end
end
