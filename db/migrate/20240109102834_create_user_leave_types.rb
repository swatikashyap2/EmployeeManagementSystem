class CreateUserLeaveTypes < ActiveRecord::Migration[7.0]
  def change
    create_table :user_leave_types do |t|
      t.integer :user_id
      t.integer :leave_type_id
      
      t.timestamps
    end
  end
end
