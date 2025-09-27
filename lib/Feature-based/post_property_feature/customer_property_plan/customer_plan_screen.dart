import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'customer_plan_controller.dart';

class CustomerPlanScreen extends StatelessWidget {
  final CustomerPlanController controller = Get.put(CustomerPlanController());

  final TextEditingController propertyIdController = TextEditingController();
  final TextEditingController userIdController = TextEditingController();
  final TextEditingController planDaysIdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Submit Customer Plan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          return Column(
            children: [
              TextField(
                controller: propertyIdController,
                decoration: InputDecoration(labelText: 'Property ID'),
              ),
              TextField(
                controller: userIdController,
                decoration: InputDecoration(labelText: 'User ID'),
              ),
              TextField(
                controller: planDaysIdController,
                decoration: InputDecoration(labelText: 'Plan Days ID'),
              ),
              SizedBox(height: 20),
              controller.isLoading.value
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                onPressed: () {
                  controller.submitCustomerPlan(
                    propertyId: propertyIdController.text.trim(),
                    userId: userIdController.text.trim(),
                    planDaysId: planDaysIdController.text.trim(),
                  );
                },
                child: Text('Submit Plan'),
              ),
            ],
          );
        }),
      ),
    );
  }
}
