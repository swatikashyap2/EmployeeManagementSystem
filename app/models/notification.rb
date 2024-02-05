
class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :recipient, class_name: "User", dependent: :destroy
  belongs_to :notifiable, polymorphic: true,  dependent: :destroy

end