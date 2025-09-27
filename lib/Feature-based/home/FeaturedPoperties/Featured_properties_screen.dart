// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// import '../../property_details/property_details.dart';
//
//
//
// class PropertyCard extends StatelessWidget {
//   final String title;
//   final String price;
//   final String location;
//   final bool isHorizontal;
//   final Color primaryColor;
//   final Color accentColor;
//   final Color cardColor;
//   final Color secondaryTextColor;
//   final VoidCallback onViewDetails;
//
//   const PropertyCard({
//     super.key,
//     required this.title,
//     required this.price,
//     required this.location,
//     required this.isHorizontal,
//     required this.primaryColor,
//     required this.accentColor,
//     required this.cardColor,
//     required this.secondaryTextColor,
//     required this.onViewDetails,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 170,
//       width: isHorizontal ? 220 : double.infinity,
//       margin: EdgeInsets.only(right: isHorizontal ? 12 : 0),
//       decoration: BoxDecoration(
//         color: cardColor,
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(color: primaryColor, width: 1.5),
//         boxShadow: [
//           BoxShadow(
//             color: primaryColor.withOpacity(0.08),
//             blurRadius: 10,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Padding(
//         padding: const EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               title,
//               style: TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//                 color: primaryColor,
//                 letterSpacing: 0.2,
//               ),
//               maxLines: 1,
//               overflow: TextOverflow.ellipsis,
//             ),
//             const SizedBox(height: 2),
//             Text(
//               location,
//               style: const TextStyle(
//                 color: Colors.black87,
//                 fontSize: 14,
//                 letterSpacing: 0.2,
//               ),
//               maxLines: 1,
//               overflow: TextOverflow.ellipsis,
//             ),
//             const SizedBox(height: 8),
//             Text(
//               price,
//               style: TextStyle(
//                 fontWeight: FontWeight.w700,
//                 color: accentColor,
//                 fontSize: 16,
//                 letterSpacing: 0.3,
//               ),
//             ),
//             const Spacer(),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Flexible(
//                   child: TextButton(
//                     onPressed: onViewDetails,
//                     child: Card(
//                       color: const Color(0xFFe57c42),
//                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
//                       child: Container(
//                         height: 40,
//                         width: 120,
//                         alignment: Alignment.center,
//                         padding: const EdgeInsets.symmetric(horizontal: 12),
//                         child: const Text(
//                           'View Details',
//                           style: TextStyle(fontSize: 14, color: Colors.white),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 IconButton(
//                   icon: const Icon(Icons.favorite_border),
//                   color: const Color(0xFFe57c42),
//                   onPressed: () {
//                     // TODO: Add favorite logic
//                   },
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
//
// // Featured Properties Screen
// class FeaturedPropertiesScreen extends StatelessWidget {
//   final Color primaryColor;
//   final Color accentColor;
//   final Color backgroundColor;
//   final Color cardColor;
//   final Color secondaryTextColor;
//   final Color bottomNavbar;
//
//   const FeaturedPropertiesScreen({
//     super.key,
//     required this.primaryColor,
//     required this.accentColor,
//     required this.backgroundColor,
//     required this.cardColor,
//     required this.secondaryTextColor,
//     required this.bottomNavbar,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final featuredProperties = [
//       {
//         'title': 'Luxury Villa in Banjara Hills',
//         'price': '₹1,50,000 / month',
//         'location': 'Banjara Hills, Hyderabad',
//       },
//       {
//         'title': 'Modern Apartment in Gachibowli',
//         'price': '₹80,000 / month',
//         'location': 'Gachibowli, Hyderabad',
//       },
//       {
//         'title': 'Spacious Plot in Madhapur',
//         'price': '₹40,000 / month',
//         'location': 'Madhapur, Hyderabad',
//       },
//       {
//         'title': 'Premium Flat in Hitech City',
//         'price': '₹95,000 / month',
//         'location': 'Hitech City, Hyderabad',
//       },
//       {
//         'title': 'Cozy House in Jubilee Hills',
//         'price': '₹1,20,000 / month',
//         'location': 'Jubilee Hills, Hyderabad',
//       },
//       {
//         'title': 'Elegant Apartment in Kondapur',
//         'price': '₹70,000 / month',
//         'location': 'Kondapur, Hyderabad',
//       },
//       {
//         'title': 'Luxury Villa in Manikonda',
//         'price': '₹1,80,000 / month',
//         'location': 'Manikonda, Hyderabad',
//       },
//       {
//         'title': 'Commercial Plot in Kukatpally',
//         'price': '₹50,000 / month',
//         'location': 'Kukatpally, Hyderabad',
//       },
//       {
//         'title': 'Modern Flat in Begumpet',
//         'price': '₹85,000 / month',
//         'location': 'Begumpet, Hyderabad',
//       },
//       {
//         'title': 'Spacious House in Uppal',
//         'price': '₹65,000 / month',
//         'location': 'Uppal, Hyderabad',
//       },
//     ];
//
//     return PopScope(
//       canPop: true,
//       onPopInvoked: (didPop) {
//         if (didPop) {
//           // Handle back navigation if needed
//         }
//       },
//       child: Scaffold(
//         backgroundColor: Colors.transparent,
//         body: Container(
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//               colors: [backgroundColor, backgroundColor],
//             ),
//           ),
//           child: Column(
//             children: [
//               AppBar(
//                 backgroundColor: cardColor,
//                 elevation: 0,
//                 title: Text(
//                   'Featured Properties',
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 20,
//                     letterSpacing: 0.5,
//                   ),
//                 ),
//                 leading: IconButton(
//                   icon: Icon(Icons.arrow_back, color: bottomNavbar, size: 26),
//                   onPressed: () => Navigator.pop(context),
//                 ),
//               ),
//               Expanded(
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
//                   child: ListView.builder(
//                     physics: const BouncingScrollPhysics(),
//                     itemCount: featuredProperties.length,
//                     itemBuilder: (context, index) {
//                       final property = featuredProperties[index];
//                       return Padding(
//                         padding: const EdgeInsets.only(bottom: 12),
//                         child: PropertyCard(
//                           title: property['title']!,
//                           price: property['price']!,
//                           location: property['location']!,
//                           isHorizontal: false,
//                           primaryColor: primaryColor,
//                           accentColor: accentColor,
//                           cardColor: cardColor,
//                           secondaryTextColor: secondaryTextColor,
//                           onViewDetails: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => PropertyDetailsScreen(
//                                   propertyName: property['title']!,
//                                   location: property['location']!,
//                                   price: property['price']!,
//                                 ),
//                               ),
//                             );
//                           },
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }




///////////




import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../property_details/property_details.dart';
import 'featured_PropertiesController.dart';
import 'featured_property_card.dart';

class Properties_listScreen extends StatelessWidget {
  final String title;
  final Color primaryColor;
  final Color accentColor;
  final Color cardColor;
  final Color secondaryTextColor;
  final Color backgroundColor;
  final Color bottomNavbar;

  const Properties_listScreen({
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
    final controller = Get.find<PropertiesController>();

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
                  letterSpacing: 0.5,
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
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  physics: const BouncingScrollPhysics(),
                  itemCount: filteredList.length,
                  itemBuilder: (context, index) {
                    final property = filteredList[index];

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

                    return FeaturedPropertyCard(
                      title: property.title ?? 'N/A',
                      price: property.price != null ? '₹${property.price} / month' : 'N/A',
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
                              price: property.price != null ? '₹${property.price}' : '',
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

