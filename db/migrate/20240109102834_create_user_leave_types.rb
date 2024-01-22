class CreateUserLeaveTypes < ActiveRecord::Migration[7.0]
  def change
    create_table :user_leave_types do |t|
      t.integer :user_id, foreign_key: true
      t.integer :leave_type_id, foreign_key: true
      
      t.timestamps
    end
  end
end
