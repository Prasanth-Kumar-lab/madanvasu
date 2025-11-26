import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/shared_pref_helper.dart';
import 'Notification_controller.dart';
class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});
  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}
class _NotificationsScreenState extends State<NotificationsScreen> {
  final NotificationController notificationController =
  Get.put(NotificationController());
  String? userId;
  String? username;
  String? email;
  String? mobileNumber;
  @override
  void initState() {
    super.initState();
    _loadUserData();
  }
  Future<void> _loadUserData() async {
    userId = await SharedPrefHelper.getUserData('id');
    username = await SharedPrefHelper.getUserData('personName');
    email = await SharedPrefHelper.getUserData('email');
    mobileNumber = await SharedPrefHelper.getUserData('mobileNumber');
    debugPrint("Loaded User Data:");
    debugPrint("User ID: $userId");
    debugPrint("Username: $username");
    debugPrint("Email: $email");
    debugPrint("Mobile: $mobileNumber");
    if (userId != null) {
      debugPrint(" Fetching notifications for user_id: $userId");
      await notificationController.fetchNotifications(int.parse(userId!));
    } else {
      debugPrint("No user ID found in SharedPrefHelper.");
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFDE7),
      appBar: AppBar(
        title: const Text(
          "Notifications",
          style: TextStyle(color: Color(0xFFe57c42)),
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Color(0xFFe57c42)),
      ),
      body: Obx(() {
        if (notificationController.isLoading.value) {
          // 🌀 Loading state
          return const Center(
            child: CircularProgressIndicator(color: Color(0xFFe57c42)),
          );
        }

        if (notificationController.notifications.isEmpty) {
          return const Center(
            child: Text(
              "No notifications available.",
              style: TextStyle(color: Color(0xFFe57c42), fontSize: 16),
            ),
          );
        }

        return RefreshIndicator(
          color: const Color(0xFFe57c42),
          onRefresh: () async {
            if (userId != null) {
              await notificationController.fetchNotifications(int.parse(userId!));
            }
          },
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: notificationController.notifications.length,
            itemBuilder: (context, index) {
              final item = notificationController.notifications[index];

              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: const Color(0xFFe4b201), width: 0.9),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.notifications, color: Color(0xFFe57c42)),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.message ?? "No message available.",
                              style: const TextStyle(
                                fontSize: 16,
                                color: Color(0xFFe4b201),
                              ),
                            ),
                            const SizedBox(height: 6),
                            if (item.expiryDate != null)
                              Text(
                                "Expiry Date: ${item.expiryDate}",
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            if (item.addedDateTime != null)
                              Text(
                                "Added on: ${item.addedDateTime}",
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
