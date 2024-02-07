class NotificationsController < ApplicationController
    before_action :set_all_notifications, only: %i[index read_notification  notification_popup]
    before_action :set_notification, only: %i[read_notification show]
  
    def index
    end

    def notification_popup
		respond_to do |format|
			format.js
		end
    end

	# def show
	# 	@notification.update(read: true)
	# 	@notifications = Notification.where(recipient_id: current_user.id, read: false)
  #       respond_to do|format|
  #           format.js
  #       end
	# end

    def read_notification
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
  