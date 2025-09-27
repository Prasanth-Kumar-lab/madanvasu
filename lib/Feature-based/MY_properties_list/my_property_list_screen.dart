import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:madhanvasu_app/utils/shared_pref_helper.dart';

import '../home/FeaturedPoperties/featured_property_card.dart';
import '../property_details/property_details.dart';
import 'my_property_list_controller.dart';

class MyPropertyListScreen extends StatefulWidget {
  final Color primaryColor;
  final Color accentColor;
  final Color cardColor;
  final Color secondaryTextColor;

  const MyPropertyListScreen({
    Key? key,
    required this.primaryColor,
    required this.accentColor,
    required this.cardColor,
    required this.secondaryTextColor,
  }) : super(key: key);

  // Optional: Provide fromArguments factory for route pushing
  factory MyPropertyListScreen.fromArguments() {
    final args = Get.arguments ?? {};
    return MyPropertyListScreen(
      primaryColor: args['primaryColor'] ?? const Color(0xFFe4b201),
      accentColor: args['accentColor'] ?? const Color(0xFF757575),
      cardColor: args['cardColor'] ?? Colors.white,
      secondaryTextColor: args['secondaryTextColor'] ?? const Color(0xFFe4b201),
    );
  }

  @override
  State<MyPropertyListScreen> createState() => _MyPropertyListScreenState();
}

class _MyPropertyListScreenState extends State<MyPropertyListScreen> {
  final MyPropertyListController controller = Get.put(MyPropertyListController(''));
  String? userId;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadUserId();
  }

  Future<void> loadUserId() async {
    final id = await SharedPrefHelper.getUserData('id');

    if (id != null && id.isNotEmpty) {
      setState(() {
        userId = id;
        isLoading = false;
      });
      controller.updateUserId(id);
      controller.fetchProperties();
    } else {
      setState(() {
        isLoading = false;
      });
      Get.snackbar(
        'Error',
        'User ID not found. Please login again.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              widget.primaryColor.withOpacity(0.1),
              widget.cardColor.withOpacity(0.1),
            ],
          ),
        ),
        child: Column(
          children: [
            AppBar(
              backgroundColor: widget.cardColor,
              elevation: 0,
              title: const Text(
                'My Properties',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, size: 26),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            Expanded(
              child: isLoading
                  ? Center(child: CircularProgressIndicator(color: widget.accentColor))
                  : Obx(() {
                if (controller.isLoading.value) {
                  return Center(
                    child: CircularProgressIndicator(color: widget.accentColor),
                  );
                } else if (controller.errorMessage.isNotEmpty) {
                  return Center(
                    child: Text(
                      controller.errorMessage.value,
                      style: TextStyle(color: widget.secondaryTextColor),
                    ),
                  );
                } else if (controller.properties.isEmpty) {
                  return Center(
                    child: Text(
                      'No properties found.',
                      style: TextStyle(color: widget.secondaryTextColor),
                    ),
                  );
                }

                return RefreshIndicator(
                  onRefresh: () => controller.fetchProperties(),
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    physics: const BouncingScrollPhysics(),
                    itemCount: controller.properties.length,
                    itemBuilder: (context, index) {
                      final property = controller.properties[index];

                      final location = [
                        property.streetName ?? '',
                        property.villageId ?? '',
                        property.mandalId ?? '',
                        property.pinCode ?? '',
                      ].where((e) => e.trim().isNotEmpty).join(', ');

                      return FeaturedPropertyCard(
                        title: property.title ?? 'No Title',
                        price: property.price != null
                            ? '₹${property.price} / month'
                            : 'N/A',
                        location: location,
                        isHorizontal: false,
                        primaryColor: widget.primaryColor,
                        accentColor: Colors.green,
                        cardColor: widget.cardColor,
                        secondaryTextColor: widget.secondaryTextColor,
                        propertyId: property.id ?? '',
                        onViewDetails: () {
                          Get.to(() => PropertyDetailsScreen(
                            id: property.id ?? '',
                            propertyName: property.title ?? '',
                            location: location,
                            price: property.price != null
                                ? '₹${property.price}'
                                : '',
                            description:
                            property.floorPlanDescription ?? "No Description",
                          ));
                        },
                      );
                    },
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
