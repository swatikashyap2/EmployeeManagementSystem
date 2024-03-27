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
        mail(to: @leave_request.reporting_manager.email, subject: "#{@leave_request.user&.first_name.titleize} request a leave!")
    end

    def leave_approved_notification(leave_request)
        @leave_request = leave_request
        mail(to: @leave_request.user.email, subject: 'Leave Request Approved')
    end

    def send_password_email(user, default_password)
        @user = user
        @default_password = default_password
        mail(to: @user.email, subject: 'Your Default Password')
    end
end
