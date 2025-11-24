import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../property_details/property_details.dart';
import '../FeaturedPoperties/featured_property_card.dart';
import '../Available_properties/Available_properties_controller.dart';

class AvailablePropertyListScreen extends StatelessWidget {
  final String title;
  final Color primaryColor;
  final Color accentColor;
  final Color cardColor;
  final Color secondaryTextColor;
  final Color backgroundColor;
  final Color bottomNavbar;

  const AvailablePropertyListScreen({
    Key? key,
    required this.title,
    required this.primaryColor,
    required this.accentColor,
    required this.cardColor,
    required this.secondaryTextColor,
    required this.backgroundColor,
    required this.bottomNavbar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<Available_PropertiesController>();

    final TextEditingController searchController = TextEditingController();
    final RxString searchText = ''.obs;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [backgroundColor, backgroundColor],
          ),
        ),
        child: Column(
          children: [
            AppBar(
              backgroundColor: cardColor,
              elevation: 0,
              title: Text(
                title,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: bottomNavbar, size: 26),
                onPressed: () => Navigator.pop(context),
              ),
            ),

            // Search Field
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Search by name, price, or location',
                  prefixIcon: Icon(Icons.search, color: secondaryTextColor),
                  suffixIcon: Obx(() {
                    return searchText.value.isNotEmpty
                        ? IconButton(
                      icon: Icon(Icons.clear, color: secondaryTextColor),
                      onPressed: () {
                        searchController.clear();
                        searchText.value = '';
                      },
                    )
                        : SizedBox.shrink();
                  }),
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: primaryColor, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: primaryColor, width: 1.5),
                  ),
                ),
                onChanged: (value) {
                  searchText.value = value.toLowerCase().trim();
                },
              ),
            ),

            // Property List
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return Center(
                    child: CircularProgressIndicator(color: accentColor),
                  );
                }

                final filteredList = controller.propertiesList.where((property) {
                  final title = property.title?.toLowerCase() ?? '';
                  final price = property.price?.toString().toLowerCase() ?? '';
                  final street = property.streetName?.toLowerCase() ?? '';

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

                  final pinCode = property.pinCode?.toLowerCase() ?? '';

                  final location = '$street $villageName $mandalName $pinCode';

                  final query = searchText.value;

                  return title.contains(query) ||
                      price.contains(query) ||
                      location.contains(query);
                }).toList();

                if (filteredList.isEmpty) {
                  return Center(
                    child: Text(
                      'No properties found.',
                      style: TextStyle(color: secondaryTextColor),
                    ),
                  );
                }

                return ListView.builder(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  physics: const BouncingScrollPhysics(),
                  itemCount: filteredList.length,
                  itemBuilder: (context, index) {
                    final property = filteredList[index];

                    final villageName = controller.villagesList
                        .firstWhereOrNull(
                            (v) => v.id == property.villageId)
                        ?.name ??
                        '';
                    final mandalName = controller.mandalsList
                        .firstWhereOrNull(
                            (m) => m.id == property.mandalId)
                        ?.name ??
                        '';

                    final location = [
                      property.streetName ?? '',
                      villageName,
                      mandalName,
                      property.pinCode ?? '',
                    ].where((e) => e.trim().isNotEmpty).join(', ');

                    return FeaturedPropertyCard(
                      title: property.title ?? 'N/A',
                      price: property.price != null
                          ? '₹${property.price}${property.propertyFor == 'Rent' ? ' / month' : ''}'
                          : 'N/A',

                      location: location,
                      isHorizontal: false,
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
                              description:
                              property.floorPlanDescription ?? "No Description",
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
      ),
    );
  }
}
