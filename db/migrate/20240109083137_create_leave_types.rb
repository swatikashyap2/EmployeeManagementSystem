class CreateLeaveTypes < ActiveRecord::Migration[7.0]
  def change
    create_table :leave_types do |t|
      t.string :name
      t.integer :count

      t.timestamps
    end
  end
end
