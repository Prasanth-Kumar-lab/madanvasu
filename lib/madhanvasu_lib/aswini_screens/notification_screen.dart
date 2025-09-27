import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  final List<String> notifications = [
    "Your monthly subscription is expiring soon!",
    //"Your property got 15 views :)",
    "Your Property has been posted Successfully.",
    //"You Property is saved by 6 people.",
  ];

   NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFDE7),
      appBar: AppBar(
        title: const Text("Notifications"),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Color(0xFFe57c42)),
      ),
      body: ListView.builder(
        
        padding: const EdgeInsets.all(16),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
  return Container(
    margin: const EdgeInsets.only(bottom: 12),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: Color(0xFFe4b201), width: 0.9),
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 4,
          offset: Offset(0, 2),
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
            child: Text(
              notifications[index],
              style: const TextStyle(fontSize: 16, color: Color(0xFFe4b201)),
            ),
          ),
        ],
      ),
    ),
  );
},


      ),
    );
  }
}
