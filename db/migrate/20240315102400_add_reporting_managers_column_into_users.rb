class AddReportingManagersColumnIntoUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :reporting_managers, :integer, array: true, default: []
  end
end
