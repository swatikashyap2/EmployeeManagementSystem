import consumer from "./consumer";

consumer.subscriptions.create("NotificationsChannel", {
  received(data) {
    $('#notification_one').prepend('<li>' + data.notification.message + '</li>');
  }
});
