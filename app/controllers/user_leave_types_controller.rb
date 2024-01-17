class UserLeaveTypesController < ApplicationController
    
    def edit
        @user = User.find(params[:id])
        @user_leave_types = @user.user_leave_types.includes(:leave_type)
        respond_to do |format|
          format.js
        end
      end
      

      def update
        @user = User.find(params[:id])
        user_leave_types_params = params[:user_leave_types]

        user_leave_types_params.each do |k, leave_user|
          @user_leave_type = UserLeaveType.find(k.to_i)
            permitted_attributes = leave_user.permit(:count)
            @user_leave_type.assign_attributes(permitted_attributes)
            @user_leave_type.save!
        end
      
        redirect_to users_path, notice: 'Leave types updated successfully.'
      end
      
      
      
    private
        def user_leave_type_params
            params.require(:user_leave_types).permit(:count, :leave_type_id)
        end
end
