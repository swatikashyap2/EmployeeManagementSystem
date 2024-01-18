class LeaveRequestsController < ApplicationController

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
        def leave_request_params
            params.require(:leave_request).permit(:leave_type_id, :selected_from, :selected_to)
        end
end
