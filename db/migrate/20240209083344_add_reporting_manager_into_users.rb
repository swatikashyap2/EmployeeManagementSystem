class AddReportingManagerIntoUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :reporting_manager_id, :integer
  end
end
