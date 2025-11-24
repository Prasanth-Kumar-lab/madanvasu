
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'mandals_controller.dart';

class MandalView extends StatelessWidget {
  final String stateId;
  final String districtId;

  const MandalView({
    Key? key,
    required this.stateId,
    required this.districtId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MandalController controller = Get.find();

    controller.fetchMandals(stateId: stateId, districtId: districtId);

    return Scaffold(
      appBar: AppBar(title: const Text("Mandals")),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.mandalList.isEmpty) {
          return const Center(child: Text("No mandals found."));
        }

        return ListView.builder(
          itemCount: controller.mandalList.length,
          itemBuilder: (context, index) {
            final mandal = controller.mandalList[index];
            return ListTile(
              title: Text(mandal.mandalName),
              subtitle: Text("ID: ${mandal.id}, Active: ${mandal.activeStatus}"),
            );
          },
        );
      }),
    );
  }
}
