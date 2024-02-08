class HomeController < ApplicationController
	def index 
		user_leaves = []
		current_user.user_leave_types.each do |user_leave_type|
		  user_leaves << { name: user_leave_type.leave_type.name, y: 14 }
		end
		gon.leaves = user_leaves
	 end
	

	def new

	end
	  
end
