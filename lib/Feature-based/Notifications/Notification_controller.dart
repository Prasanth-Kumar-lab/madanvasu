import 'package:get/get.dart';

class NotificationController extends GetxController {
  var unreadCount = 0.obs;

  void fetchUnreadCount() async {
    // logic
    await Future.delayed(Duration(seconds: 1));
    unreadCount.value = 2;
  }
}
