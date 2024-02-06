// app/javascript/channels/notifications_channel.js
import consumer from "./consumer"

consumer.subscriptions.create("NotificationsChannel", {
  received(data) {
    console.log("Received notification:", data.message);
    // Create a new table row for the received notification
    let newRow = "<tr>";
    newRow += "<td>" + data.message + "</td>";
    // Append the new row to the notifications table
    $("#notification-one tbody").append(newRow);
  }
});
