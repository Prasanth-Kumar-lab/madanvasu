import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class share_options extends StatelessWidget {
  final String phoneNumber;
  final String email;
  final VoidCallback? onBack;

  const share_options({
    Key? key,
    required this.phoneNumber,
    required this.email,
    this.onBack,
  }) : super(key: key);


  Future<void> _launchCaller(String number) async {
    final Uri url = Uri(scheme: 'tel', path: number);
    await _tryLaunch(url, 'Could not launch dialer');
  }

  Future<void> _launchSms(String number) async {
    final Uri url = Uri(scheme: 'sms', path: number);
    await _tryLaunch(url, 'Could not send SMS');
  }

  Future<void> _launchWhatsApp(String number) async {
    final Uri url = Uri.parse("https://wa.me/$number");
    await _tryLaunch(url, 'Could not open WhatsApp', useExternal: true);
  }

  Future<void> _launchEmail(String email) async {
    final Uri url = Uri(scheme: 'mailto', path: email);
    await _tryLaunch(url, 'Could not open email');
  }

  Future<void> _tryLaunch(Uri url, String errorMsg, {bool useExternal = false}) async {
    try {
      final success = await launchUrl(
        url,
        mode: useExternal ? LaunchMode.externalApplication : LaunchMode.platformDefault,
      );
      if (!success) throw errorMsg;
    } catch (e) {
      Get.snackbar("Error", "$e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color iconColor = const Color(0xFFe57c42);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _iconWithLabel(Icons.call, "Call", () => _launchCaller(phoneNumber), iconColor),
            _iconWithLabel(Icons.sms, "SMS", () => _launchSms(phoneNumber), iconColor),
            _iconWithLabel(Icons.camera_alt, "WhatsApp", () => _launchWhatsApp(phoneNumber), iconColor),
            _iconWithLabel(Icons.email, "Email", () => _launchEmail(email), iconColor),
          ],
        ),
        if (onBack != null)
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: TextButton.icon(
              onPressed: onBack,
              icon: const Icon(Icons.arrow_back, color: Color(0xFFe57c42)),
              label: const Text('Back', style: TextStyle(color: Color(0xFFe57c42))),
            ),
          ),
      ],
    );
  }

  Widget _iconWithLabel(IconData icon, String label, VoidCallback onTap, Color color) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 30),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
