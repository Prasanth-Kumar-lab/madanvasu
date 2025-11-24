import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';

class CustomContactBottomSheet extends StatelessWidget {
  final String mobileNumber;
  final String emailId;
  final String address;
  final VoidCallback onCallTap;
  final VoidCallback onEmailTap;

  const CustomContactBottomSheet({
    Key? key,
    required this.mobileNumber,
    required this.emailId,
    required this.address,
    required this.onCallTap,
    required this.onEmailTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 6,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Contact Details",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFe57c42))),
              const SizedBox(height: 16),

              InkWell(
                onTap: onCallTap,
                onLongPress: () {
                  Clipboard.setData(ClipboardData(text: mobileNumber));
                  Get.snackbar("Copied", "Number copied to clipboard");
                },
                child: Row(
                  children: [
                    const Icon(Icons.phone, color: Color(0xFFe57c42)),
                    const SizedBox(width: 8),
                    Text(mobileNumber, style: const TextStyle(fontSize: 16)),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              InkWell(
                onTap: onEmailTap,
                onLongPress: () {
                  Clipboard.setData(ClipboardData(text: emailId));
                  Get.snackbar("Copied", "Email copied to clipboard");
                },
                child: Row(
                  children: [
                    const Icon(Icons.email, color: Color(0xFFe57c42)),
                    const SizedBox(width: 8),
                    Text(emailId, style: const TextStyle(fontSize: 16)),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              InkWell(
                onLongPress: () {
                  Clipboard.setData(ClipboardData(text: address));
                  Get.snackbar("Copied", "Address copied to clipboard");
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.location_on, color: Color(0xFFe57c42)),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(address,
                          style: const TextStyle(fontSize: 16)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
