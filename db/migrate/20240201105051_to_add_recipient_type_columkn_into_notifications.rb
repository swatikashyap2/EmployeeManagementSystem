class ToAddRecipientTypeColumknIntoNotifications < ActiveRecord::Migration[7.0]
  def change
    add_column :notifications, :recipient_type, :string
    add_column :notifications, :read, :boolean
  end
end
