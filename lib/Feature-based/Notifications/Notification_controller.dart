import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'Notification_model.dart';


class NotificationController extends GetxController {
  var unreadCount = 0.obs;
  var isLoading = false.obs;
  var notifications = <ExpiryNotification>[].obs;
  var userDetails = <UserDetail>[].obs;

  /// Fetch expiry notifications from API
  Future<void> fetchNotifications(int userId) async {
    isLoading.value = true;

    try {
      var headers = {
        'Cookie': 'ci_session=d17a706dc2811623d26922b44d3fc83b7a3b648d',
      };

      var url = Uri.parse(
          'https://madanvasu.in/new/apis/Api_expiry_notifications/getexpiry_notifications?user_id=$userId');

      var request = http.MultipartRequest('GET', url);
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        var jsonData = json.decode(responseBody);

        // Parse the API response using your model
        final notificationList = NotificationList.fromJson(jsonData);

        if (notificationList.data != null) {
          notifications.value =
              notificationList.data!.expiryNotifications ?? [];
          userDetails.value = notificationList.data!.users ?? [];

          // Example: Count only unread (you can modify this logic as needed)
          unreadCount.value = notifications.length;
        } else {
          notifications.clear();
          userDetails.clear();
          unreadCount.value = 0;
        }
      } else {
        print("Error: ${response.reasonPhrase}");
      }
    } catch (e) {
      print("Error fetching notifications: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
