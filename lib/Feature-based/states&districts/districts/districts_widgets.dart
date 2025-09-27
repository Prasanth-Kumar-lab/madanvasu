// lib/views/district_view.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'distric_controller.dart';
import 'districts_model.dart';

class DistrictView extends StatefulWidget {
  final String stateId;

  const DistrictView({Key? key, required this.stateId}) : super(key: key);

  @override
  State<DistrictView> createState() => _DistrictViewState();
}

class _DistrictViewState extends State<DistrictView> {
  final DistrictController controller = Get.find();
  DistrictData? selectedDistrict;

  @override
  void initState() {
    super.initState();
    controller.fetchDistricts(widget.stateId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.districtList.isEmpty) {
          return const Center(child: Text("No districts found."));
        }

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: DropdownButtonFormField<DistrictData>(
            isExpanded: true,
            decoration: const InputDecoration(
              labelText: "Select District",
              border: OutlineInputBorder(),
            ),
            value: selectedDistrict,
            items: controller.districtList.map((district) {
              return DropdownMenuItem<DistrictData>(
                value: district,
                child: Text(district.districtName),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                selectedDistrict = value;
              });

              // You can do something with selectedDistrict
              if (value != null) {
                Get.snackbar(
                  "Selected",
                  "You selected: ${value.districtName}",
                  snackPosition: SnackPosition.BOTTOM,
                );

                // Optionally navigate to mandal screen here...
              }
            },
          ),
        );
      }),
    );
  }
}
