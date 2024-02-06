class NotificationsChannel < ApplicationCable::Channel
  def subscribed
<<<<<<< HEAD
    stream_from "notifications:#{current_user.id}"
=======
    stream_from current_user
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
>>>>>>> 575a87cc3f874200f45c7d3e22d5ca884ffba272
  end
end
