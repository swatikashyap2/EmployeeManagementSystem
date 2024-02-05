class NotificationsController < ApplicationController
    before_action :set_all_notifications, only: %i[index read]
    before_action :set_notification, only: %i[read]
  
    def index
    end
  
    def read
        @notification.update(read: true)
        respond_to do|format|
            format.js
        end
    end
  
    private
  
    def set_notification
      @notification = Notification.find(params[:id])
    end
  
    def set_all_notifications
      @notifications = Notification.where(recipient_id: current_user.id, read: false)
    end
  end
  