class LeaveRequestsController < ApplicationController
    before_action :set_user_leave_types, only: %i[new]
    before_action :set_leave_request, only: %i[leave_approve leave_reject]
    def index
        if is_admin?
            @leave_requests = LeaveRequest.order(created_at: :desc)
        elsif is_manager?
            @leave_requests = current_user.leave_requests.order(created_at: :desc)
        else
            @leave_requests = current_user.leave_requests.order(created_at: :desc)
        end 
    end

    def new
        @leave_request = LeaveRequest.new()
    end

    def create
        @leave_requests = LeaveRequest.new(leave_request_params)
        if @leave_requests.save!
            redirect_to leave_requests_path, notice: "Request Created Successfully."
        else
            redirect_to new_leave_request_path
        end
    end


    def leave_approve
        @leave_request = LeaveRequest.find(params[:id])
        if @leave_request.update(approve: true)
            @user_leave_type= @leave_request.user_leave_type
            if @user_leave_type.leave_type.name.eql?("Short Leave")
                @user_leave_type.update(leave_count: 0)
            else
                date_from = Date.parse("#{@leave_request.leave_from}") if @leave_request.leave_from.present?
                date_to = Date.parse("#{@leave_request.leave_to}") if @leave_request.leave_to.present?
                if date_from == date_to
                    no_of_days = 1
                else
                    no_of_days = @leave_request.day_type.eql?("full day") ? (date_to - date_from).to_i : 0.5
                end
                leave_count = @user_leave_type.leave_count
                @user_leave_type.update(leave_count: leave_count - no_of_days)
            end
        end
        redirect_to leave_requests_path
    end

    def leave_reject
        @leave_requests = LeaveRequest.find(params[:id])
        @leave_requests.update(approve: false)
        redirect_to leave_requests_path
    end

    private

        def set_user_leave_types
            @user_leave_types = current_user.user_leave_types.includes(:leave_type).collect{|user_leave_type|[user_leave_type.leave_type.name, user_leave_type.id] if user_leave_type.leave_count > 0 }.compact  
        end
        def set_leave_request

        end
        def leave_request_params
            params.require(:leave_request).permit(:user_leave_type_id, :leave_from, :leave_to, :time_from, :time_to, :user_id, :day_type, :reporting_manager_id)
        end
end
