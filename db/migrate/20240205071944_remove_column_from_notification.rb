class RemoveColumnFromNotification < ActiveRecord::Migration[7.0]
  def change
    remove_column :notifications, :action, :string
  end
end
