import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../home/FeaturedPoperties/featured_property_card.dart';
import '../../../property_details/property_details.dart';
import 'category_basedon_controller.dart';

class Category_Properties_listScreen extends StatelessWidget {
  final String title;
  final Color primaryColor;
  final Color accentColor;
  final Color cardColor;
  final Color secondaryTextColor;
  final String categoryId;

  Category_Properties_listScreen({
    Key? key,
    required this.title,
    required this.primaryColor,
    required this.accentColor,
    required this.cardColor,
    required this.secondaryTextColor,
    required this.categoryId,
  }) : super(key: key);

  final TextEditingController searchController = TextEditingController();
  final RxString searchText = ''.obs;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CategoryBasedonController>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          AppBar(
            backgroundColor: cardColor,
            // backgroundColor: AppColors.secondary.withOpacity(0.8),

            elevation: 0,
            title: Text(
              title,
              style: const TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 20,
                letterSpacing: 0.5,
              ),
            ),
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: secondaryTextColor, size: 26),
              onPressed: () => Navigator.pop(context),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),

            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search by name, price, or location',
                prefixIcon: Icon(Icons.search, color: secondaryTextColor),
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color:primaryColor, width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color:primaryColor, width: 1.5),
                ),
              ),
              onChanged: (value) {
                searchText.value = value.toLowerCase().trim();
              },
            ),

          ),

          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return Center(child: CircularProgressIndicator(color: accentColor));
              }

              final filteredProperties = controller.propertiesList.where((property) {
                final matchesCategory = property.propertyCatId == categoryId;

                final title = property.title?.toLowerCase() ?? '';
                final price = property.price?.toString() ?? '';

                final villageName = controller.villagesList
                    .firstWhereOrNull((v) => v.id == property.villageId)
                    ?.name
                    ?.toLowerCase() ??
                    '';

                final mandalName = controller.mandalsList
                    .firstWhereOrNull((m) => m.id == property.mandalId)
                    ?.name
                    ?.toLowerCase() ??
                    '';

                final streetName = property.streetName?.toLowerCase() ?? '';
                final pinCode = property.pinCode?.toLowerCase() ?? '';

                final locationData = '$streetName $villageName $mandalName $pinCode';
                final query = searchText.value;

                final matchesSearch = query.isEmpty ||
                    title.contains(query) ||
                    price.contains(query) ||
                    locationData.contains(query);

                return matchesCategory && matchesSearch;
              }).toList();

              if (filteredProperties.isEmpty) {
                return const Center(
                  child: Text(
                    'No properties found for this category.',
                    style: TextStyle(color: Colors.black87, fontSize: 16),
                  ),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                physics: const BouncingScrollPhysics(),
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
                    property.streetName?.trim() ?? '',
                    villageName.trim(),
                    mandalName.trim(),
                    property.pinCode?.trim() ?? '',
                  ].where((e) => e.isNotEmpty).join(', ');

                  return FeaturedPropertyCard(
                    title: property.title ?? 'N/A',
                    price: property.price != null ? '₹${property.price} / month' : 'N/A',
                    location: location,
                    isHorizontal: false,
                    primaryColor: primaryColor,
                    accentColor: Colors.green,
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
                            description: property.floorPlanDescription ?? "No Description",
                          ),
                        ),
                      );
                    },
                    propertyId: property.id ?? '',
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
