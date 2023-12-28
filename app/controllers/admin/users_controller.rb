class Admin::UsersController <  ApplicationController
	before_action :authenticate_user!
	
	def index
		@users = User.all
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			redirect_to admin_users_path
		else
			render 'new'
		end
	end

	def edit 
		@devise_mapping = Devise.mappings[:user]
		@user=User.find(params[:id])
	end

	def update 
		@user=User.find(params[:id])
		if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
			if @user.update_without_password(user_params)
				redirect_to admin_users_path
			else
				render 'edit'
			end
		else
			if @user.update(user_params)
				redirect_to admin_users_path
			else
				render 'edit'
			end
		end
	
	end

	def destroy
		@user=User.find(params[:id])
		@user.destroy
		redirect_to admin_users_path
	end

	private

		def user_params
			params.require(:user).permit(:email, :password, :password_confirmation, :current_password, :first_name, :last_name, :phone, :address, :zip_code, :employee_code, :dob, :role_id)
		end
end
