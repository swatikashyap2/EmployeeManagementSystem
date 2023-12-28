class ApplicationController < ActionController::Base
	layout :layout
	protect_from_forgery with: :exception

  include Pundit::Authorization
	rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

	before_action :configure_permitted_parameters, if: :devise_controller?
	before_action :set_default_role, only: [:create]
	add_flash_types :info, :error, :success

	private

	def set_default_role
		params[:user] ||= {}
		params[:user][:role_id] = 3
	end

	def user_not_authorized
		flash[:alert] = 'You are not authorized to perform this action.'
		redirect_to root_path
	end

	def after_sign_in_path_for(resource)
		if resource.is_a?(User)
			if current_user.role.name.eql?("Admin")
				admin_users_path
			elsif current_user.role.name.eql?("Manager")
				manager_users_path
			else
				users_path
			end
		end
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
		devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:email, :password, :password_confirmation, :role_id)}
	end

end

  

 