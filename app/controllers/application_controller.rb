class ApplicationController < ActionController::Base
	before_action :authenticate_user! 
	helper_method :is_admin?, :is_manager?, :is_employee?
	helper_method :current_user
	
	include Pundit::Authorization
	protect_from_forgery with: :exception
  	rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  	
	before_action :configure_permitted_parameters, if: :devise_controller?
	add_flash_types :info, :error, :success

	def is_admin?
		current_user.role.name == "admin" ? true : false
	end

	def is_manager?
		current_user.role.name == "manager" ? true : false
	end

	def is_employee?
		current_user.role.name == "employee" ? true : false
	end
	
	private

		def user_not_authorized
			flash[:alert] = 'You are not authorized to perform this action.'
			redirect_to root_path
		end
		
		def layout
			if devise_controller?
				'devise'
			else
				'application'
			end
		end

	
	protected
		def configure_permitted_parameters
			devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:email, :password, :password_confirmation, :role_id)}
			
		end

end

  

 