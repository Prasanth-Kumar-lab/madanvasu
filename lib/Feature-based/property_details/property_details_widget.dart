import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:madhanvasu_app/Feature-based/property_details/property_details_controller.dart';

import 'Property_details_model.dart';

class PropertyView extends StatefulWidget {
  final String propertyId;

  const PropertyView({required this.propertyId, Key? key}) : super(key: key);

  @override
  State<PropertyView> createState() => _PropertyViewState();
}

class _PropertyViewState extends State<PropertyView> {
  final PropertyController controller = Get.put(PropertyController());

  @override
  void initState() {
    super.initState();
    controller.fetchPropertyDetails(widget.propertyId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFDE7),

      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (controller.errorMessage.isNotEmpty) {
          return Center(child: Text(controller.errorMessage.value));
        }

        final model = controller.propertyDetailsModel.value;

        if (model == null || model.propertyDetails == null || model.propertyDetails!.isEmpty) {
          return Center(child: Text('No property details found.'));
        }

        final property = model.propertyDetails!.first;

        String getStateName(String? id) =>
            model.states?.firstWhereOrNull((s) => s.id == id)?.name ?? 'N/A';

        String getDistrictName(String? id) =>
            model.districts?.firstWhereOrNull((d) => d.id == id)?.name ?? 'N/A';

        String getMandalName(String? id) =>
            model.mandals?.firstWhereOrNull((m) => m.id == id)?.name ?? 'N/A';

        String getVillageName(String? id) =>
            model.villages?.firstWhereOrNull((v) => v.id == id)?.name ?? 'N/A';

        String getCategoryName(String? id) =>
            model.propertiesCategories?.firstWhereOrNull((c) => c.id == id)?.title ?? 'N/A';

        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            buildOverviewTab(property, getCategoryName, getStateName, getDistrictName, getMandalName, getVillageName),
          ],
        );
      }),
    );
  }

  Widget buildOverviewTab(
      PropertyDetails property,
      String Function(String?) getCategoryName,
      String Function(String?) getStateName,
      String Function(String?) getDistrictName,
      String Function(String?) getMandalName,
      String Function(String?) getVillageName,
      ) {
    final categoryTitle = getCategoryName(property.propertyCatId);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFe4b201), width: 1.8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sectionTitle("Property Details"),
            DetailRow(label: "Title", value: property.title ?? "-"),
            DetailRow(label: "Price", value: property.price ?? "-"),
            DetailRow(label: "Property Type", value: categoryTitle),
            DetailRow(label: "Property For", value: property.propertyFor ?? "-"),
            // DetailRow(label: "Property Status", value: property.propertyStatusId ?? "-"),
            if (categoryTitle == 'Apartment') ...[
              DetailRow(label: "Total Area", value: "${property.totalArea ?? '-'} Sq Ft"),
              DetailRow(label: "Built-up Area", value: "${property.builtupArea ?? '-'} Sq Ft"),
              DetailRow(label: "Bedrooms", value: property.bedrooms ?? "-"),
              DetailRow(label: "Bathrooms", value: property.bathrooms ?? "-"),
              DetailRow(label: "Parking", value: property.parking ?? "-"),
            ] else if (categoryTitle == 'Villa') ...[
              DetailRow(label: "Villa Built-up Area", value: "${property.villaBuiltupArea ?? '-'} Sq Ft"),
              DetailRow(label: "Villa Floors", value: property.villaFloors ?? "-"),
              DetailRow(label: "Villa Garden", value: "${property.villaGarden ?? '-'} Sq Ft"),
            ] else if (categoryTitle == 'Plot') ...[
              DetailRow(label: "Plot Area", value: "${property.plotArea ?? '-'} Sq Ft"),
              DetailRow(label: "Plot Length", value: property.plotLength ?? "-"),
              DetailRow(label: "Plot Width", value: property.plotWidth ?? "-"),
              DetailRow(label: "Facing Direction", value: property.facingDirection ?? "-"),
            ] else if (categoryTitle == 'Commercial Space') ...[
              DetailRow(label: "Commercial Area", value: "${property.commercialArea ?? '-'} Sq Ft"),
              DetailRow(label: "Floor Level", value: property.floorLevel ?? "-"),
              DetailRow(label: "Suitable For", value: property.suitableFor ?? "-"),
            ],

            DetailRow(label: "Street", value: property.streetName ?? "-"),
            DetailRow(label: "Village", value: getVillageName(property.villageId)),
            DetailRow(label: "Mandal", value: getMandalName(property.mandalId)),
            DetailRow(label: "District", value: getDistrictName(property.districtId)),
            DetailRow(label: "State", value: getStateName(property.stateId)),
            DetailRow(label: "Floor Plan Description", value: property.floorPlanDescription ?? "-"),

            DetailRow(label: "Pincode", value: property.pinCode ?? "-"),
            const SizedBox(height: 22),

            // sectionTitle("Additional Details"),
            // DetailRow(label: "Booking Amount", value: property.bookingAmount ?? "-"),
            // DetailRow(label: "Maintenance Charges", value: property.maintenanceCharges ?? "-"),
            // DetailRow(label: "RERA Number", value: property.reraNumber ?? "-"),
            // DetailRow(label: "Floor Plan Title", value: property.floorPlanTitle ?? "-"),
            // DetailRow(label: "Floor Plan Area", value: "${property.floorPlanArea ?? '-'} Sqft"),
            // DetailRow(label: "Floor Plan Description", value: property.floorPlanDescription ?? "-"),
            // const SizedBox(height: 22),

            sectionTitle("Agent / Entry Info"),
            DetailRow(label: "Person Name", value: property.personName ?? "-"),
            DetailRow(label: "Person Number", value: property.personNumber ?? "-"),
            DetailRow(label: "Added On", value: property.addedDateTime ?? "-"),
          ],
        ),
      ),
    );
  }


  Widget sectionTitle(String title) => Padding(
    padding: const EdgeInsets.only(bottom: 14),
    child: Text(
      title,
      style: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Color(0xFFe4b201),
        letterSpacing: 0.5,
      ),
    ),
  );
}

class DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const DetailRow({required this.label, required this.value, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              "$label:",
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Text(
              value,
              style: const TextStyle(fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }
}
