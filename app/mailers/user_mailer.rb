class UserMailer < ApplicationMailer
    default from: 'swatikashyap00000@gmail.com'

    def approve_email(leave_request)
        @leave_request = leave_request
        @url  = 'http://www.gmail.com'
        mail(to: @leave_request.user.email, subject: 'Leave Approved!')
    end

    def reject_email(leave_request)
        @leave_request = leave_request
        @url  = 'http://www.gmail.com'
        mail(to: @leave_request.user.email, subject: 'Leave Rejected!')
    end


    def leave_apply_email(leave_request)
        @leave_request = leave_request
        @url  = 'http://www.gmail.com'
        mail(to: @leave_request.user.email, subject: 'Leave Rejected!')
    end

    def leave_cancel_email(leave_request)
        @leave_request = leave_request
        @url  = 'http://www.gmail.com'
        mail(to: @leave_request.user.email, subject: 'Leave Rejected!')
    end
end
