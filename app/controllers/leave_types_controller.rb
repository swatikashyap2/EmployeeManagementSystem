class LeaveTypesController < ApplicationController
    def index
        @leave_types = LeaveType.all.order(created_at: :desc)
        authorize @leave_types
    end

    def new
        @leave_type = LeaveType.new()
        authorize @leave_type
    end
    
    def create
        @leave_type = LeaveType.new(leave_type_params)
        authorize @leave_type
        if @leave_type.save
            redirect_to leave_types_path
            flash[:notice] = "Leave Created Successfully."
        else
            render :action => "new"
        end
    end
    

    def edit
        @leave_type = LeaveType.find(params[:id])
        authorize @leave_type
        respond_to do |format|
            format.js
            format.html
        end
    end

    def update
        @leave_type = LeaveType.find(params[:id])
        authorize @leave_type
        if @leave_type.update(leave_type_params)
            redirect_to leave_types_path
            flash[:notice] = "Leave Updated Successfully."
        else
            render :action => "edit"
        end
    end

    def destroy
        @leave_type = LeaveType.find(params[:id])
        authorize @leave_type
        @leave_type.destroy
        redirect_to leave_types_path
        flash[:notice] = "Leave Deleted Successfully."
    end

    private
        def leave_type_params
            params.require(:holiday).permit(:name, :count)
        end 
end
