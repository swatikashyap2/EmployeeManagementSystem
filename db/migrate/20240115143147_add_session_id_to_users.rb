class AddSessionIdToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :session_id, :integer, limit: 1
  end
end
