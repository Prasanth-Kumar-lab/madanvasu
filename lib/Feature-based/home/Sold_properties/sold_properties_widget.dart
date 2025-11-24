import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:madhanvasu_app/Feature-based/home/Sold_properties/sold_properties_controller.dart';

import '../../../utils/All_PropertyCard_widget.dart';
import '../../../utils/Common_buttons&widgets/AppLoding_widget.dart';
import '../../../utils/shared_pref_helper.dart';
import '../../property_details/property_details.dart';

class SoldProperties extends StatelessWidget {
  final Color primaryColor;
  final Color accentColor;
  final Color cardColor;
  final Color secondaryTextColor;

  const SoldProperties({
    Key? key,
    required this.primaryColor,
    required this.accentColor,
    required this.cardColor,
    required this.secondaryTextColor,
  }) : super(key: key);

  /// Get villageId from Shared Preferences
  Future<String?> getUserVillageId() async {
    return await SharedPrefHelper.getUserData('villageId');
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SoldPropertiesController>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchSoldProperties();
    });

    return FutureBuilder<String?>(
      future: getUserVillageId(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CustomLoader());
        }

        final userVillageId = snapshot.data ?? '';
        debugPrint('User Village ID (Sold): $userVillageId');

        return Obx(() {
          if (controller.isLoading.value) {
            return Center(child: CustomLoader());
          }

          // Filter properties based on villageId
          final filteredProperties = controller.propertiesList.where((property) {
            return property.villageId == userVillageId;
          }).toList();

          if (filteredProperties.isEmpty) {
            return Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text(
                  'No sold properties found in your village.',
                  style: TextStyle(color: secondaryTextColor),
                ),
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            scrollDirection: Axis.vertical,
            itemCount: filteredProperties.length,
            itemBuilder: (context, index) {
              final property = filteredProperties[index];

              final villageName = controller.villagesList
                  .firstWhereOrNull((v) => v.id == property.villageId)
                  ?.name ??
                  '';
              final mandalName = controller.mandalsList
                  .firstWhereOrNull((m) => m.id == property.mandalId)
                  ?.name ??
                  '';

              final location = [
                property.streetName,
                villageName,
                mandalName,
                property.pinCode,
              ].where((element) => element != null && element.isNotEmpty).join(', ');

              return PropertyCard(
                title: property.title ?? 'N/A',
                price: property.price != null ? '₹${property.price}' : 'N/A',
                location: location,
                isHorizontal: true,
                primaryColor: primaryColor,
                accentColor: accentColor,
                cardColor: cardColor,
                secondaryTextColor: secondaryTextColor,
                onViewDetails: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PropertyDetailsScreen(
                        id: property.id ?? '',
                        propertyName: property.title ?? '',
                        location: location,
                        price: property.price != null ? '₹${property.price}' : '',
                        description:
                        property.floorPlanDescription ?? 'No description available',
                      ),
                    ),
                  );
                },
                propertyId: '${property.id}',
              );
            },
            separatorBuilder: (context, index) => const SizedBox(height: 12),
          );
        });
      },
    );
  }
}


