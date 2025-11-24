
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:madhanvasu_app/Feature-based/states&districts/villages/villages_controller.dart';

class VillageView extends StatelessWidget {
  final String stateId;
  final String districtId;
  final String mandalId;

  const VillageView({
    Key? key,
    required this.stateId,
    required this.districtId,
    required this.mandalId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final VillageController controller = Get.find();

    controller.fetchVillages(
      stateId: stateId,
      districtId: districtId,
      mandalId: mandalId,
    );

    return Scaffold(
      appBar: AppBar(title: const Text("Villages")),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.villageList.isEmpty) {
          return const Center(child: Text("No villages found."));
        }

        return ListView.builder(
          itemCount: controller.villageList.length,
          itemBuilder: (context, index) {
            final village = controller.villageList[index];
            return ListTile(
              title: Text(village.villageName),
              subtitle: Text("ID: ${village.id}, PIN: ${village.pinCode ?? 'N/A'}"),
              trailing: Text("Active: ${village.activeStatus}"),
            );
          },
        );
      }),
    );
  }
}
