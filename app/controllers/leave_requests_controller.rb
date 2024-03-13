class LeaveRequestsController < ApplicationController
    before_action :set_user_leave_types, only: %i[new edit]

    def index
        if is_admin?
            @leave_requests = LeaveRequest.order(created_at: :desc).paginate(page: params[:page], per_page: 10)
        elsif is_manager?
            @leave_requests = current_user.leave_requests.order(created_at: :desc).paginate(page: params[:page], per_page: 10)
        else
            @leave_requests = current_user.leave_requests.order(created_at: :desc).paginate(page: params[:page], per_page: 10)
        end 
		authorize @leave_requests
    end

    def new
        @leave_request = LeaveRequest.new()
		authorize @leave_request
    end

    def create
        @leave_request = LeaveRequest.new(leave_request_params)
        if params[:leave_request][:day_type] == 'half_day'
            leave_requests = current_user.leave_requests.where(approve: [true, nil], canceled: nil)
            existing_leave = leave_requests.where(user_id: @leave_request.user_id)
                                        .where(leave_from: @leave_request.leave_from..@leave_request.leave_from.end_of_day)
            if existing_leave.exists?
                redirect_to new_leave_request_path, alert: "Your leave request overlaps with an existing leave request."
                return
            end
        end
        if params[:leave_request][:day_type] == 'full_day'
            leave_requests = current_user.leave_requests.where(approve: [true, nil], canceled: nil)
            existing_leave = leave_requests.where(leave_from: @leave_request.leave_from..@leave_request.leave_from.end_of_day,leave_to: @leave_request.leave_to..@leave_request.leave_to.end_of_day)
            if existing_leave.exists?
                redirect_to new_leave_request_path, alert: "Your leave request overlaps with an existing leave request."
                return
            end
        end
        if @leave_request.save
            @user_leave_type= @leave_request.user_leave_type
            if @user_leave_type.leave_type.name.eql?("Short Leave")
                @user_leave_type.update(leave_count: 0)
            else
                date_from = Date.parse("#{@leave_request.leave_from}") if @leave_request.leave_from.present?
                date_to = Date.parse("#{@leave_request.leave_to}") if @leave_request.leave_to.present?
                if date_from == date_to
                    no_of_days = 1
                else
                    no_of_days = @leave_request.day_type.eql?("full_day") ? ((date_to - date_from).to_i + 1) : 0.5
                end
                leave_count = @user_leave_type.leave_count
                @user_leave_type.update(leave_count: leave_count - no_of_days)
            end
          
            message1 = "Hi #{@leave_request.reporting_manager.first_name.titleize}, #{current_user.first_name.titleize} has been applied for #{@leave_request.user_leave_type.leave_type.name} "
            message2 = "Hi #{current_user.first_name.titleize}, your #{@leave_request.user_leave_type.leave_type.name.titleize} has been successfully applied! "
            @leave_request.notifications.create(recipient: @leave_request.reporting_manager, user: current_user, message: message1, recipient_type: "true", read: false)
            @leave_request.notifications.create(recipient: @leave_request.user, user: current_user, message: message2, recipient_type: "true", read: false)
            
            UserMailer.leave_apply_email(@leave_request).deliver_later
            UserMailer.notify_to_admin(@leave_request).deliver_later
            # NotificationsChannel.broadcast_to(current_user, @leave_request.notifications.last)
             redirect_to leave_requests_path, notice: "Request Created Successfully."
        else
            redirect_to new_leave_request_path, error:  @leave_request.errors.full_messages
        end
    end
     
    def leave_approve    
        @leave_request = LeaveRequest.find(params[:id])
        if  @leave_request.canceled == true
            redirect_to leave_requests_path, alert: "Leave has been cancelled."
        elsif @leave_request.update(approve: true)
            @user_leave_type= @leave_request.user_leave_type
            message = " Hi #{@leave_request.user.first_name.titleize}, your #{@leave_request.user_leave_type.leave_type.name.titleize} has been successfully approved!"
            @leave_request.notifications.create(recipient: @leave_request.user, user: current_user, message: message, notifiable: @leave_request, recipient_type: "true", read: false)
            UserMailer.approve_email(@leave_request).deliver_now
            redirect_to leave_requests_path,notice: "Leave Approved Successfully."
        end
    end

    def leave_reject
        @leave_request = LeaveRequest.find(params[:id])
        if  @leave_request.canceled == true
            redirect_to leave_requests_path, alert: "Leave has been cancelled."
        elsif @leave_request.update(approve: false)
            @user_leave_type= @leave_request.user_leave_type
            
            message = " Hi #{@leave_request.user.first_name.titleize}, your #{@leave_request.user_leave_type.leave_type.name.titleize} has been rejected!"
            @leave_request.notifications.create(recipient: @leave_request.user, user: current_user, message: message, notifiable: @leave_request, recipient_type: "true", read: false)
            
            if @user_leave_type.leave_type.name.eql?("Short Leave")
                @user_leave_type.update(leave_count: 1)
            else
                date_from = Date.parse("#{@leave_request.leave_from}") if @leave_request.leave_from.present?
                date_to = Date.parse("#{@leave_request.leave_to}") if @leave_request.leave_to.present?
                if date_from == date_to
                    no_of_days = 1
                else
                    no_of_days = @leave_request.day_type.eql?("full_day") ? ((date_to - date_from).to_i + 1) : 0.5
                end
                leave_count = @user_leave_type.leave_count
                @user_leave_type.update(leave_count: leave_count + no_of_days)
            end
            UserMailer.reject_email(@leave_request).deliver_now
            redirect_to leave_requests_path, notice: "Leave rejected."
        end
    end

    def cancel
        @leave_request = LeaveRequest.find_by(id: params[:id])
        if @leave_request.update(canceled: true)
            @user_leave_type= @leave_request.user_leave_type
            if @user_leave_type.leave_type.name.eql?("Short Leave")
                @user_leave_type.update(leave_count: 1)
            else
                date_from = Date.parse("#{@leave_request.leave_from}") if @leave_request.leave_from.present?
                date_to = Date.parse("#{@leave_request.leave_to}") if @leave_request.leave_to.present?
                if date_from == date_to
                    no_of_days = 1
                else
                    no_of_days = @leave_request.day_type.eql?("full_day") ? ((date_to - date_from).to_i + 1) : 0.5
                end
                leave_count = @user_leave_type.leave_count
                @user_leave_type.update(leave_count: leave_count + no_of_days)
            end

            message1 = " Hi #{@leave_request.reporting_manager.first_name.titleize}, #{current_user.first_name.titleize} has been cancel #{@leave_request.user_leave_type.leave_type.name} "
            message2 = " Hi #{@leave_request.user.first_name.titleize}, you have been cancelled your  #{@leave_request.user_leave_type.leave_type.name.titleize}"
            @leave_request.notifications.create(recipient: @leave_request.reporting_manager, user: current_user, message: message1,  notifiable: @leave_request, recipient_type: "true", read: false)
            @leave_request.notifications.create(recipient: @leave_request.user, user: current_user, message: message2, notifiable: @leave_request, recipient_type: "true", read: false)

            UserMailer.leave_cancel_email(@leave_request).deliver_now
            redirect_to leave_requests_path, notice: "Leave canceled."
        end 
    end
    
    def checkleavedates
        @leavetofrom = LeaveRequest.where(approve: [true, nil], canceled: nil).pluck(:leave_from, :leave_to)
        @leave_between = @leavetofrom.flatten.map { |date| date.strftime("%a, %d %b %Y") } 
      
        params_date = Date.parse(params[:key1])
        @format_date = params_date.strftime("%a, %d %b %Y")
      
        @date_diffs = []
      
        @leavetofrom.each do |leave|
          leave_from = Date.parse(leave[0].strftime("%a, %d %b %Y"))
          leave_to = Date.parse(leave[1].strftime("%a, %d %b %Y"))  
          dates_between = (leave_from..leave_to).to_a.map { |date| date.strftime("%a, %d %b %Y") }
      
          @date_diffs << dates_between
        end
      
        @date_diffs = @date_diffs.flatten
      
        if @leave_between.include?(@format_date) || @date_diffs.include?(@format_date)
          render json: { leavedates: true }
        else
          render json: { leavedates: false }
        end
    end
      
      

    def edit
        @leave_request = LeaveRequest.find(params[:id])
    end
    
    def update
        @leave_request = LeaveRequest.find(params[:id])
        if params[:leave_request][:day_type] == 'half_day'
            existing_leave = LeaveRequest.where(user_id: @leave_request.user_id)
                                        .where(leave_from: @leave_request.leave_from..@leave_request.leave_from.end_of_day)
            if existing_leave.exists?
                redirect_to new_leave_request_path, alert: "Your leave request overlaps with an existing leave request."
                return
            end
        end
        if params[:leave_request][:day_type] == 'full_day'
            existing_leave = current_user.leave_requests.where(leave_from: @leave_request.leave_from..@leave_request.leave_from.end_of_day,leave_to: @leave_request.leave_to..@leave_request.leave_to.end_of_day)
            if existing_leave.exists?
                redirect_to new_leave_request_path, alert: "Your leave request overlaps with an existing leave request."
                return
            end
        end
        if @leave_request.update(leave_request_params)
            @user_leave_type= @leave_request.user_leave_type
            if @user_leave_type.leave_type.name.eql?("Short Leave")
                @user_leave_type.update(leave_count: 0)
            else
                date_from = Date.parse("#{@leave_request.leave_from}") if @leave_request.leave_from.present?
                date_to = Date.parse("#{@leave_request.leave_to}") if @leave_request.leave_to.present?
                if date_from == date_to
                    no_of_days = 1
                else
                    no_of_days = @leave_request.day_type.eql?("full_day") ? ((date_to - date_from).to_i + 1) : 0.5
                end
                leave_count = @user_leave_type.leave_count
                @user_leave_type.update(leave_count: leave_count - no_of_days)
            end
          
            message1 = "Hi #{@leave_request.reporting_manager.first_name.titleize}, #{current_user.first_name.titleize} has been update his #{@leave_request.user_leave_type.leave_type.name} from  "
            message2 = "Hi #{current_user.first_name.titleize}, your #{@leave_request.user_leave_type.leave_type.name.titleize} has been successfully applied! "
            @leave_request.notifications.create(recipient: @leave_request.reporting_manager, user: current_user, message: message1, recipient_type: "true", read: false)
            @leave_request.notifications.create(recipient: @leave_request.user, user: current_user, message: message2, recipient_type: "true", read: false)
            
            UserMailer.leave_apply_email(@leave_request).deliver_later
            UserMailer.notify_to_admin(@leave_request).deliver_later
            # NotificationsChannel.broadcast_to(current_user, @leave_request.notifications.last)
             redirect_to leave_requests_path, notice: "Request Created Successfully."
        else
            redirect_to new_leave_request_path, error:  @leave_request.errors.full_messages
        end
    end
    private

    def set_user_leave_types
        @user_leave_types = current_user.user_leave_types.includes(:leave_type).collect{|user_leave_type|[user_leave_type.leave_type.name, user_leave_type.id] if user_leave_type.leave_count > 0 }.compact  
    end

    def leave_request_params
        params.require(:leave_request).permit(:user_leave_type_id, :leave_from, :leave_to, :time_from, :time_to, :user_id, :day_type, :reporting_manager_id, :description, :half_type)
    end
end

