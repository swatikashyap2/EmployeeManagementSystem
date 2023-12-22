class UsersController < ApplicationController
	before_action :authenticate_user!
	before_action :set_user, only: %i[edit, update, destroy, edit_user]
  def index
		@users = User.employee
		authorize @users
	end

	def new
		
	end

	def create
		
	end
	def edit
	
	end

	def edit_user 
		debugger
		@devise_mapping = Devise.mappings[:user]

		authorize @user
	end

	def update 
		authorize @user
	end
	def show
	end

	private

	def set_user
		debugger
		@user = User.find_by(id: params[:id])
	end

	def user_params
		params.require(:user).permit(:name, :last_name, :phone, :address, :zip_code, :employee_code, :dob)
	end

end
