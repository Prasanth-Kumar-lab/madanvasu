import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:madhanvasu_app/Feature-based/profile/terms&Conditions/terms&Conditions_controller.dart';
import '../../../app/configuration/themes/app_colors.dart';

class TermsConditionsScreen extends StatelessWidget {
  const TermsConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TermsConditionsController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms & Conditions', style: TextStyle(color: Colors.black)),
        backgroundColor: AppColors.secondary,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: SafeArea(
            child: Html(
              data: controller.termsContent.value,
              style: {
                "p": Style(
                  margin: Margins.zero,
                  lineHeight: LineHeight.number(1.2),
                ),
                "br": Style(
                  margin: Margins.zero,

                ),
              },
            ),
          ),
        );
      }),
    );
  }
}
