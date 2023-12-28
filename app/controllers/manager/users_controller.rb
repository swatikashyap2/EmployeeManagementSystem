
class Manager::UsersController < ApplicationController
	before_action :authenticate_user!
	def index
		@users = User.manager_employee
	end

	def new
	end

	def create
	end

	def edit 
	end

	def update 
	end

	private
	def user_params
		params.require(:user).permit(:first_name, :last_name, :phone, :address, :zip_code, :employee_code, :dob)

	end
end