import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_html/flutter_html.dart';
import '../../../app/configuration/themes/app_colors.dart';
import 'About_us_controller.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AboutUsController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us', style: TextStyle(color: Colors.black)),
        backgroundColor: AppColors.secondary,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (controller.aboutTitle.isNotEmpty)
                Text(
                  controller.aboutTitle.value,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              const SizedBox(height: 10),
              if (controller.aboutImage.isNotEmpty)
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    'https://madanvasu.in/new/assets/backend/about/${controller.aboutImage.value}',
                    errorBuilder: (context, error, stackTrace) =>
                    const Text('Image could not be loaded'),
                  ),
                ),
              const SizedBox(height: 16),
              Html(data: controller.aboutDescription.value),
            ],
          ),
        );
      }),
    );
  }
}
