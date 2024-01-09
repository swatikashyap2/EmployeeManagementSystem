class RolesController < ApplicationController
	before_action :authenticate_user!

	def index
		@roles = Role.all.order(created_at: :desc).paginate(page: params[:page], per_page: 2)
		authorize @roles
	end

	def new
		@role = Role.new
		authorize @role
	end

	def create
		@role = Role.new(role_params)
		authorize @role
		if @role.save
			redirect_to roles_path
			flash[:notice] = "Role Created Successfully."
		else
			render 'new'
		end
	end

	def edit
		@role = Role.find(params[:id])
		authorize @role
		respond_to do |format|
			format.js
			format.html
		end
	end

	def update
		@role = Role.find(params[:id])
		authorize @role
		if @role.update(role_params)
			redirect_to roles_path
			flash[:notice] = "Role Updated Successfully."
		else
			render 'edit'
		end
	end

	def destroy
		@role = Role.find(params[:id])
		authorize @role
		@role.destroy
		redirect_to roles_path
		flash[:notice] = "Role Deleted Successfully."
	end

	private
		def role_params
			params.require(:role).permit(:name)
		end
end
