class CreateLeaveRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :leave_requests do |t|

      t.timestamps
    end
  end
end
