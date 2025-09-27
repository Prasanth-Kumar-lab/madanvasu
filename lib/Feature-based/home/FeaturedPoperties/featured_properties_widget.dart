// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../../utils/All_PropertyCard_widget.dart';
// import 'featured_PropertiesController.dart';
// import '../../property_details/property_details.dart';
//
// class PropertiesView extends StatelessWidget {
//   final Color primaryColor;
//   final Color accentColor;
//   final Color cardColor;
//   final Color secondaryTextColor;
//
//   const PropertiesView({
//     Key? key,
//     required this.primaryColor,
//     required this.accentColor,
//     required this.cardColor,
//     required this.secondaryTextColor,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.find<PropertiesController>();
//
//     return Scaffold(
//       body: Obx(() {
//         if (controller.isLoading.value) {
//           return Center(child: CircularProgressIndicator(color: accentColor));
//         }
//
//         if (controller.propertiesList.isEmpty) {
//           return Align(
//             alignment: Alignment.center,
//             child: Padding(
//               padding: const EdgeInsets.only(left: 16.0),
//               child: Text(
//                 'No properties found.',
//                 style: TextStyle(color: secondaryTextColor),
//               ),
//             ),
//           );
//         }
//
//         return ListView.separated(
//           padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
//           scrollDirection: Axis.horizontal,
//           itemCount: controller.propertiesList.length,
//           itemBuilder: (context, index) {
//             final property = controller.propertiesList[index];
//
//
//             final villageName = controller.villagesList
//                 .firstWhereOrNull((v) => v.id == property.villageId)
//                 ?.name ??
//                 '';
//             final mandalName = controller.mandalsList
//                 .firstWhereOrNull((m) => m.id == property.mandalId)
//                 ?.name ??
//                 '';
//
//             final location = [
//               property.streetName,
//               villageName,
//               mandalName,
//               property.pinCode,
//             ].where((element) => element != null && element.isNotEmpty).join(', ');
//
//
//             return PropertyCard(
//               title: property.title ?? 'N/A',
//               price: property.price != null ? '₹${property.price} / month' : 'N/A',
//               location: location,
//               isHorizontal: true,
//               primaryColor: primaryColor,
//               accentColor: accentColor,
//               cardColor: cardColor,
//               secondaryTextColor: secondaryTextColor,
//               onViewDetails: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => PropertyDetailsScreen(
//                       id: property.id ?? '',
//
//                       propertyName: property.title ?? '',
//                       location: location,
//                       price: property.price != null ? '₹${property.price}' : '',
//                       description: property.floorPlanDescription ?? 'No description available',
//                       // property_status: property.floorPlanDescription ?? 'No description available',
//
//                       // property_status_id
//                     ),
//                   ),
//                 );
//               },
//               // userId: property.userId ??'',
//               propertyId: '${property.id}',
//             );
//           },
//           separatorBuilder: (context, index) => const SizedBox(width: 8),
//         );
//       }),
//     );
//   }
// }
//
//
//
//
//



///////////////////////////



import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/All_PropertyCard_widget.dart';
import '../../../utils/Common_buttons&widgets/AppLoding_widget.dart';
import '../../../utils/shared_pref_helper.dart';
import 'featured_PropertiesController.dart';
import '../../property_details/property_details.dart';

class PropertiesView extends StatelessWidget {
  final Color primaryColor;
  final Color accentColor;
  final Color cardColor;
  final Color secondaryTextColor;

  const PropertiesView({
    Key? key,
    required this.primaryColor,
    required this.accentColor,
    required this.cardColor,
    required this.secondaryTextColor,
  }) : super(key: key);

  /// Get villageId from shared preferences
  Future<String?> getUserVillageId() async {
    return await SharedPrefHelper.getUserData('villageId');
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PropertiesController>();

    return FutureBuilder<String?>(
      future: getUserVillageId(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CustomLoader());
        }

        final userVillageId = snapshot.data ?? '';
        debugPrint('User Village ID (Featured): $userVillageId');

        return Obx(() {
          if (controller.isLoading.value) {
            return Center(child: CustomLoader());
          }

          // Filter properties by villageId
          final filteredProperties = controller.propertiesList.where((property) {
            return property.villageId == userVillageId;
          }).toList();

          if (filteredProperties.isEmpty) {
            return Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text(
                  'No featured properties found in your village.',
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
                price: property.price != null ? '₹${property.price} / month' : 'N/A',
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
                        description: property.floorPlanDescription ?? 'No description available',
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
