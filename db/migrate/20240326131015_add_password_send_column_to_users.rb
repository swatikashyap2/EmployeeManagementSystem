class AddPasswordSendColumnToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :password_send, :boolean
  end
end
