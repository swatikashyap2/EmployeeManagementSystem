class UsersController < ApplicationController
	before_action :set_user, except: [:index, :new, :create]
	before_action :authenticate_user!, except: [:new, :create]
	
  	def index
		if current_user.is_employee? 
			@users = [current_user]
		elsif current_user.is_manager?
			@users = User.employees.paginate(page: params[:page], per_page: 10)
		else
			@users = User.all.paginate(page: params[:page], per_page: 10)
		end
		authorize @users
	end

	def new
		@user = User.new()
		authorize @user
	end

	def create
		@user = User.new(user_params)
		if @user.save
			# redirect_to {usl., noticer: "dsfsd"}
			redirect_to users_path
			flash[:notice] = "User Created Successfully."
		else
			render 'new'
		end
	end

	def show
		authorize @user
	end

	def edit 
		authorize @user
	end

	def update 
		authorize @user
		@devise_mapping = Devise.mappings[:user]
		if user_params[:password].blank? && user_params[:password_confirmation].blank?
			if @user.update_without_password(user_params)
				redirect_to users_path
				flash[:notice] = "User Updated Successfully."
			else
				render 'edit'
			end
		else
			if @user.update(user_params)
				redirect_to users_path
			else
				render 'edit'
			end
		end
	
	end

	def destroy
		authorize @user
		if @user.destroy
			redirect_to users_path
			flash[:notice] = "User Deleted Successfully."
		else
			redirect_to root_path
		end
	end
	

	private

		def user_params
			params.require(:user).permit(:email, :password, :password_confirmation, :current_password, :first_name, :last_name, :phone, :address, :zip_code, :employee_code, :dob, :role_id)
		end

		def set_user
			@user = User.find(params[:id])
 		end
end
