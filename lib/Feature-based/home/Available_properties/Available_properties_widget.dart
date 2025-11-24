import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/All_PropertyCard_widget.dart';
import '../../../utils/Common_buttons&widgets/AppLoding_widget.dart';
import '../../property_details/property_details.dart';
import 'Available_properties_controller.dart';
import '../../../utils/shared_pref_helper.dart';

class AvailableProperties extends StatelessWidget {
  final Color primaryColor;
  final Color accentColor;
  final Color cardColor;
  final Color secondaryTextColor;

  const AvailableProperties({
    Key? key,
    required this.primaryColor,
    required this.accentColor,
    required this.cardColor,
    required this.secondaryTextColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<Available_PropertiesController>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchProperties();
    });

    return FutureBuilder<String?>(
      future: SharedPrefHelper.getUserData('villageId'),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CustomLoader());
        }

        final userVillageId = snapshot.data ?? '';
        debugPrint('User Village ID: $userVillageId');

        return Obx(() {
          if (controller.isLoading.value) {
            return Center(child: CustomLoader());
          }

          debugPrint('All Properties:');
          for (var property in controller.propertiesList) {
            final villageName = controller.villagesList
                .firstWhereOrNull((v) => v.id == property.villageId)
                ?.name ??
                'Unknown';
            debugPrint(
                'Property ID: ${property.id}, Title: ${property.title}, Village ID: ${property.villageId}, Village Name: $villageName');
          }

          final filteredProperties = controller.propertiesList.where((property) {
            return property.villageId == userVillageId;
          }).toList();

          debugPrint('Filtered Properties (matching Village ID: $userVillageId):');
          for (var property in filteredProperties) {
            final villageName = controller.villagesList
                .firstWhereOrNull((v) => v.id == property.villageId)
                ?.name ??
                'Unknown';
            debugPrint(
                'Filtered Property ID: ${property.id}, Title: ${property.title}, Village ID: ${property.villageId}, Village Name: $villageName');
          }

          if (filteredProperties.isEmpty) {
            debugPrint('No properties found in user\'s village (ID: $userVillageId).');
            return Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text(
                  'No properties found in your village.',
                  style: TextStyle(color: secondaryTextColor),
                ),
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            scrollDirection: Axis.horizontal,
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
                price: property.price != null
                    ? '₹${property.price}${property.propertyFor == 'Rent' ? ' / month' : ''}'
                    : 'N/A',

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
                        price: property.price != null
                            ? '₹${property.price}'
                            : '',
                        description: property.floorPlanDescription ??
                            'No description available',
                      ),
                    ),
                  );
                },
                propertyId: '${property.id}',
              );
            },
            separatorBuilder: (context, index) => const SizedBox(width: 8),
          );
        });
      },
    );
  }
}