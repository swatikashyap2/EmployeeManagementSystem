class UsersController < ApplicationController
	before_action :set_user, only: [:show, :edit, :update, :destroy]
	before_action :authenticate_user!
	

	def index
		if is_employee? 
			@users = [current_user]
		elsif is_manager?
			@users = User.manager_employees.order(created_at: :desc).paginate(page: params[:page], per_page: 3)
		else
			@users = User.all.order(created_at: :desc).paginate(page: params[:page], per_page: 3)
		end
		authorize @users
	end

	def new
		@user = User.new()
		authorize @user, :new?
	end

	def create
		@user = User.new(user_params)
		authorize @user, :create?
		@user.password = 'admin@123' if user_params[:password].blank?
		@user.password_confirmation = 'admin@123' if user_params[:password].blank?
		
		if @user.save
		  redirect_to users_path
		  flash[:notice] = "User Created Successfully."
		else
		  flash[:message] = @user.errors.full_messages
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
			@user = User.find_by(id: params[:id])
		end	
		
end
