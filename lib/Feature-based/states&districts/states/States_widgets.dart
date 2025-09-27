
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:madhanvasu_app/Feature-based/states&districts/states/states_controller.dart';

class StateView extends StatelessWidget {
  const StateView({required Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final StateController controller = Get.find();

    return Scaffold(
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.statesList.isEmpty) {
          return const Center(child: Text("No states found."));
        }

        return ListView.builder(
          itemCount: controller.statesList.length,
          itemBuilder: (context, index) {
            final state = controller.statesList[index];
            return ListTile(
              title: Text(state.stateName ?? ''),
              subtitle: Text("ID: ${state.id}, Active: ${state.activeStatus}"),
            );
          },
        );
      }),
    );
  }
}
