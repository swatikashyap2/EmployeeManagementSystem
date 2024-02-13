class HomeController < ApplicationController
	def index 
		user_leaves = []
		total_leaves = 100/current_user.user_leave_types.count
		current_user.user_leave_types.each do |user_leave_type|
		  user_leaves << { name: user_leave_type.leave_type.name, y: total_leaves, leave_count: user_leave_type.leave_count , total_count: user_leave_type.total_leave_count}
		end
		gon.leaves = user_leaves
		if is_admin?
            @leave_requests = LeaveRequest.where(approve: nil, canceled: nil).order(created_at: :desc)
        elsif is_manager?
           @leave_requests = current_user.leave_requests.where(approve: nil, canceled: nil).order(created_at: :asc)
        else
           @leave_requests = current_user.leave_requests.where(approve: nil, canceled: nil).order(created_at: :asc)
        end 

		
	 end
	

	def new

	end
	  
end
