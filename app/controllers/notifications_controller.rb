class NotificationsController < ApplicationController
    before_action :set_all_notifications, only: %i[index read_notification  notification_popup search mark_all_read_notification]
    before_action :set_notification, only: %i[read_notification show]
  
    def index
        @query = params[:user_name].downcase if params[:user_name].present?
        @notifications = @notifications.includes(:user).where(user: User.search_result(@query)) if @query.present?
        @notifications =  @notifications.paginate(page: params[:page], per_page: 10)   
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
        @notification_count = @notifications.where(read: false)
        
    end

	def search
        query = params[:search].downcase
		@notifications = @notifications.includes(:user).where(user: User.search_result(query)) if query.present?
		respond_to do |format|
		  format.js
		end
	end

    def mark_all_read_notification
        @notifications.where(read: false).update(read: true)
        @notification_count = @notifications.where(read: false)
    end
	  
    private

    def set_notification
        @notification = Notification.find(params[:id])
    end

    def set_all_notifications
        @notifications = Notification.where(recipient_id: current_user.id).order(created_at: :desc)
    end
end
  