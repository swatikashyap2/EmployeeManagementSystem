class ApproveNotifier < ApplicationNotifier
  deliver_by :email do |config|
    config.mailer = "UserMailer"
    config.method = "leave_approved_notification"
  end
end









