class UserLeaveTypesController < ApplicationController
    
    def edit
        @user_leave_type = UserLeaveType.find(user_leave_type_params)
    end

    # def create
    #     @user_leave_types = UserLeaveType.new(user_leave_type_params)
    #     @user_leave_types.save
    # end

    # private
    #     def user_leave_type_params
    #         params.require(:user_leave_type).permit(:user_id, :leave_type_id)
    #     end


    private
        def user_leave_type_params
            params.require(user_leave_type).permit(:user_id, :leave_type_id, :count)
        end
end
