class UsersController < ApplicationController
	before_action :set_user, only: [:show, :edit, :update, :destroy]
	before_action :authenticate_user!
	

	def index

		if is_employee? 
			@users = [current_user]
		elsif is_manager?
			@users = User.employees.order(created_at: :desc).paginate(page: params[:page], per_page: 10)
		else
			@users = User.where.not(id: current_user.id).order(created_at: :desc).paginate(page: params[:page], per_page: 10)
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
		if @user.save
		  redirect_to users_path, notice: "User Created Successfully."
		else
		  	redirect_to new_user_path, error:  @user.errors.full_messages 
		end
	end
	  
	def checkemail
		@emails = User.pluck(:email)
		render json: {emails: @emails}
	end
	  
	
	def edit 
		if @user.dob.present? && @user.dob.is_a?(Date)
			@user.dob = @user.dob.strftime("%Y-%m-%d")
		end
		authorize @user
	end

	def update 
		authorize @user
		@devise_mapping = Devise.mappings[:user]
		if user_params[:password].blank? 
			if @user.update_without_password(user_params)
				redirect_to users_path, notice: "User Updated Successfully."
			else
				redirect_to edit_user_path,error: @user.errors.full_messages
			end
		else
			if @user.update(user_params)
				redirect_to users_path
			else
				redirect_to edit_user_path, error: @user.errors.full_messages
			end
		end
	
	end

	def destroy
		authorize @user
		if @user.destroy!
			redirect_to users_path, notice: "User Deleted Successfully."
		else
			redirect_to root_path
		end
	end

	def send_password
		@user = User.find(params[:id])
		redirect_to users_path
	end
	private 
		def user_params
			params.require(:user).permit(:email, :password, :password_confirmation, :current_password, :first_name, :last_name, :phone, :address, :zip_code, :employee_code, :dob, :role_id, :designation, :gender, :reporting_manager_id, :avatar)
		end

		def set_user
			@user = User.find_by(id: params[:id])
		end	
		
end
  