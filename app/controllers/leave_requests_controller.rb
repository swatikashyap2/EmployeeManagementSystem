class LeaveRequestsController < ApplicationController
    before_action :set_user_leave_types, only: %i[new]

    def index
        if is_admin?
            @leave_requests = LeaveRequest.all
        elsif is_manager?
            @leave_requests = current_user.leave_types
        else
            @leave_requests = current_user.leave_types
        end 
    end

    def new
        @leave_request = LeaveRequest.new()
    end

    private

        def set_user_leave_types
            @user_leave_types = current_user
                .user_leave_types
                .includes(:leave_type)
                .collect{|user_leave_type|[user_leave_type.leave_type.name, user_leave_type.id] if !user_leave_type.leave_count.eql?(0) }.compact
            
        end

        def leave_request_params
            params.require(:leave_request).permit(:leave_type_id, :leave_from, :leave_to, :time_from, :time_to, :day_type)
        end
end
