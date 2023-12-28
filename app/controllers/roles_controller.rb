class RolesController < ApplicationController
  def index
		@roles = Role.all.paginate(page: params[:page], per_page: 2)
	end

	def new
		@role = Role.new
		respond_to do |format|
			format.js
		end
	end

	def create
		@role = Role.new(role_params)
		if @role.save
			redirect_to roles_path
			flash[:notice] = "Role Created Successfully."
		else
			render 'new'
		end
	end

	def edit
		@role = Role.find(params[:id])
		respond_to do |format|
			format.js
			format.html
		end
	end

	def update
		@role = Role.find(params[:id])
		if @role.update(role_params)
			redirect_to roles_path
			flash[:notice] = "Role Updated Successfully."
		else
			render 'edit'
		end
	end

	def destroy
		@role = Role.find(params[:id])
		@role.destroy
		redirect_to roles_path
		flash[:notice] = "Role Deleted Successfully."
	end

	private
		def role_params
			params.require(:role).permit(:name)
		end
end
