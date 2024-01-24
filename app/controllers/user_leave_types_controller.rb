class UserLeaveTypesController < ApplicationController
    
    def edit
        @user = User.find(params[:id])
        @user_leave_types = @user.user_leave_types.order(created_at: :asc)
        authorize @user_leave_types
        respond_to do |format|
          format.js
        end
      end
      
      def update
        @user = User.find(params[:id])
        user_leave_types_params = params[:user_leave_types]
      
        @user.user_leave_types.each do |user_leave_type|
          leave_type_id = user_leave_type.leave_type_id.to_s
          attributes = user_leave_types_params[leave_type_id]
      
          if attributes
            permitted_attributes = attributes.permit(:leave_count)
            if user_leave_type.leave_count != permitted_attributes[:leave_count].to_i
              user_leave_type.update(permitted_attributes)
            end
          end
        end
      
        redirect_to users_path, notice: 'Leave types updated successfully.'
      end

      def show
        @user_leave_type_count = UserLeaveType.find_by(id: params[:id]).leave_count
        render json: { leave_count: @user_leave_type_count }
      end

    private
        def user_leave_type_params
            params.require(:user_leave_types).permit(:leave_count)
        end
end
