import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:madhanvasu_app/Feature-based/post_property_feature/property_plan_days/property_plan_day_controller.dart';

class PropertyPlanScreen extends StatelessWidget {
  final controller = Get.put(PropertyPlanController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Property Plan Days'),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else if (controller.planDaysList.isEmpty) {
          return Center(child: Text('No data available.'));
        } else {
          return ListView.builder(
            itemCount: controller.planDaysList.length,
            itemBuilder: (context, index) {
              final item = controller.planDaysList[index];
              return Card(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: ListTile(
                  title: Text('Plan Days: ${item.planDays}'),
                  subtitle: Text('Status: ${item.activeStatus == "1" ? "Active" : "Inactive"}'),
                  trailing: Text('ID: ${item.id}'),
                ),
              );
            },
          );
        }
      }),
    );
  }
}
