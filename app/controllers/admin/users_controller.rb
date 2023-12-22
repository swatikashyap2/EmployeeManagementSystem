class Admin::UsersController <  ApplicationController
	before_action :authenticate_user!
	
	def index
	@users = User.all
	end

	def new
	end

	def create
	end

	def edit 
		@devise_mapping = Devise.mappings[:user]
		@user=User.find(params[:id])
	end

	def update 
		@user.update(user_params)
		redirect_to admin_users_path
	end

	private
	def user
		@user=User.find_by(id: params[:id])
	end

	def user_params
		params.require(:user).permit(:name, :last_name, :phone, :address, :zip_code, :employee_code, :dob)
	end
end
