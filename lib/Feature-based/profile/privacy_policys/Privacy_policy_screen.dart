import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_html/flutter_html.dart';
import '../../../app/configuration/themes/app_colors.dart';
import 'Privacy_policy_controller.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PrivacyPolicyController());

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Privacy & Policy',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: AppColors.secondary,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 1,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Html(
            data: controller.policyContent.value.trim(), // trim whitespace here
            style: {
              "body": Style(
                margin: Margins.zero, // remove default margin on body
                // padding: Padding.zero, // remove padding on body
                color: Colors.black87,
                fontSize: FontSize(16),
                lineHeight: LineHeight(1.5),
              ),
              "p": Style(
                margin:  Margins.only(bottom: 8), // less space after paragraphs
                // padding: Padding.zero,
              ),
              "h1": Style(
                margin:  Margins.symmetric(vertical: 12),
                fontSize: FontSize(24),
                fontWeight: FontWeight.bold,
              ),
              "h2": Style(
                margin:  Margins.symmetric(vertical: 10),
                fontSize: FontSize(20),
                fontWeight: FontWeight.w600,
              ),
              "br": Style(
                // display: Display.NONE,
              ),
            },
          ),
        );
      }),
    );
  }
}
