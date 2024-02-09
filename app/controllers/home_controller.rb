class HomeController < ApplicationController
	def index 
		user_leaves = []
		current_user.user_leave_types.each do |user_leave_type|
		  user_leaves << { name: user_leave_type.leave_type.name, y: 14 }
		end
		gon.leaves = user_leaves
		if is_admin?
            @leave_requests = LeaveRequest.where(approve: nil, canceled: nil).order(created_at: :desc).paginate(page: params[:page], per_page: 10)
        elsif is_manager?
           @leave_requests = current_user.leave_requests.where(approve: nil, canceled: nil).order(created_at: :asc).paginate(page: params[:page], per_page: 10)
        else
           @leave_requests = current_user.leave_requests.where(approve: nil, canceled: nil).order(created_at: :asc).paginate(page: params[:page], per_page: 10)
        end 

		
	 end
	

	def new

	end
	  
end
