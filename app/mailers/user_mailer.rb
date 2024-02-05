class UserMailer < ApplicationMailer
    default from: 'Backspacce<info@backspacce.com>'

    def approve_email(leave_request)
        @leave_request = leave_request
        mail(to: @leave_request.user.email, subject: 'Leave Approved!')
    end

    def reject_email(leave_request)
        @leave_request = leave_request
        mail(to: @leave_request.user.email, subject: 'Leave Rejected!')
    end


    def leave_apply_email(leave_request)
        @leave_request = leave_request
        mail(to: @leave_request.user.email, subject: "Leave Requested!")
    end

    def leave_cancel_email(leave_request)
        @leave_request = leave_request
        mail(to: @leave_request.user.email, subject: 'Leave Cancelled!')
    end

    def notify_to_admin(leave_request)
        @leave_request = leave_request
        mail(to: @leave_request.reporting_manager.email, subject: "#{@leave_request.user&.first_name} request a leave!")
    end

    def leave_approved_notification(leave_request)
        @leave_request = leave_request
        mail(to: @leave_request.user.email, subject: 'Leave Request Approved')
      end
end
