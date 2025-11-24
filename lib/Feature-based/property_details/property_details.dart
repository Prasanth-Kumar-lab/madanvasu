// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:madhanvasu_app/Feature-based/property_details/property_details_controller.dart';
// import 'package:madhanvasu_app/Feature-based/property_details/property_details_widget.dart';
// import 'package:share_plus/share_plus.dart';
// // import 'package:real_estate/aswini_screens/comments_screen.dart';
// import 'package:translator/translator.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// import '../../data/Api_services/user_api_services.dart';
// import '../../utils/Common_buttons&widgets/AppLoding_widget.dart';
// import '../../utils/Common_buttons&widgets/Custom_bottom_sheet.dart';
// import '../../utils/Common_buttons&widgets/share_option.dart';
// import '../../utils/shared_pref_helper.dart';
// import '../Contact_Us/Contact_us_controller.dart';
// import '../../app/configuration/ themes/app_colors.dart';
// import '../Reviews/All_Reviews_list/comments_screen.dart';
// import '../SavedProperties/saved_properties_controller.dart';
// import 'Property_details_model.dart';
//
// class PropertyDetailsScreen extends StatefulWidget {
//
//   final String id;
//   final String propertyName;
//   final String location;
//   final String price;
//   final String description;
//   // final String property_status;
//
//
//
//   const PropertyDetailsScreen({
//     super.key,
//     required this.id,
//
//     required this.propertyName,
//     required this.location,
//     required this.price,
//     required this.description,
//     // required this.property_status,
//
//   });
//
//   @override
//   State<PropertyDetailsScreen> createState() => _PropertyDetailsScreenState();
// }
//
// class _PropertyDetailsScreenState extends State<PropertyDetailsScreen> {
//   int selectedTab = 0;
//   final controller = PropertyController();
//   PropertyDetailsModel? propertyDetailsModel;
//   late final PropertyDetails propertyDetail;
//   // late Future<PropertyDetails?> propertyDetailsFuture;
//   String? userId;
//   final favoriteController = Get.put(FavoritePropertiesController(ApiService()));
//
//
//   @override
//   void initState() {
//     super.initState();
//     // controller.getPropertyDetails(widget.id);
//     // propertyDetailsFuture = controller.getPropertyDetails(widget.id);
//     loadUserId();
//
//   }
//
//
//   Future<void> loadUserId() async {
//     final id = await SharedPrefHelper.getUserData('id');
//     setState(() {
//       userId = id;
//     });
//   }
//
//   Future<void> handleFavoriteTap() async {
//     if (userId == null || userId!.isEmpty) {
//       Get.snackbar(
//         'Error',
//         'Please login to manage favorites',
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Colors.red,
//         colorText: Colors.white,
//       );
//       return;
//     }
//
//     if (widget.id.isEmpty) {
//       Get.snackbar(
//         'Error',
//         'Invalid property ID',
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Colors.red,
//         colorText: Colors.white,
//       );
//       return;
//     }
//
//     try {
//       final isFav = favoriteController!.isFavorite(widget.id);
//
//       if (isFav) {
//         final success = await favoriteController!.removeFavorite(widget.id);
//         if (success) {
//           Get.snackbar(
//             'Removed',
//             'Property removed from favorites',
//             snackPosition: SnackPosition.BOTTOM,
//             backgroundColor: Colors.orange,
//             colorText: Colors.white,
//           );
//         } else {
//           Get.snackbar(
//             'Error',
//             'Failed to remove favorite',
//             snackPosition: SnackPosition.BOTTOM,
//             backgroundColor: Colors.red,
//             colorText: Colors.white,
//           );
//         }
//       } else {
//         final result = await ApiService.addFavoriteProperty(
//           userId: userId!,
//           propertyId: widget.id,
//         );
//
//         if (result['status'] == true) {
//           favoriteController!.favoriteIds.add(widget.id);
//           Get.snackbar(
//             'Success',
//             result['message'] ?? 'Added to favorites',
//             snackPosition: SnackPosition.BOTTOM,
//             backgroundColor: Colors.green,
//             colorText: Colors.white,
//           );
//         } else if ((result['message'] ?? '').contains('Already Added')) {
//           Get.snackbar(
//             'Info',
//             result['message'] ?? 'Property already in favorites',
//             snackPosition: SnackPosition.BOTTOM,
//             backgroundColor: Colors.blueGrey,
//             colorText: Colors.white,
//           );
//         } else {
//           Get.snackbar(
//             'Error',
//             result['message'] ?? 'Failed to add favorite',
//             snackPosition: SnackPosition.BOTTOM,
//             backgroundColor: Colors.red,
//             colorText: Colors.white,
//           );
//         }
//       }
//     } catch (e) {
//       print('Favorite error: $e');
//       Get.snackbar(
//         'Error',
//         'Something went wrong',
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Colors.red,
//         colorText: Colors.white,
//       );
//     }
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFFFFDE7),
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         // backgroundColor: AppColors.secondary.withOpacity(0.8),
//
//         elevation: 1,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Color(0xFFe57c42)),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: const Text(
//           'Property Details',
//           style: TextStyle(color: Colors.black),
//         ),
//         iconTheme: const IconThemeData(color: Color(0xFFe57c42)),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Container(
//                 width: double.infinity,
//                 padding: const EdgeInsets.only(top: 10),
//                 child: Card(
//                   elevation: 3,
//                   color: Colors.white,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   margin: EdgeInsets.zero,
//                   child: Container(
//                     padding: const EdgeInsets.all(16),
//                     decoration: BoxDecoration(
//                       border: Border.all(color: Color(0xFFe4b201), width: 1.5),
//                       borderRadius: BorderRadius.circular(14),
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         // Text(
//                         //   widget.id,
//                         //   style: const TextStyle(
//                         //     color: Color(0xFF179a3a),
//                         //     fontSize: 16,
//                         //   ),
//                         // ),
//
//                         Text(
//                           widget.propertyName,
//                           style: const TextStyle(
//                             color: Color(0xFFe4b201),
//                             fontSize: 22,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         const SizedBox(height: 8),
//                         Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             const Icon(Icons.location_on, color: Color(0xFFe57c42)),
//                             const SizedBox(width: 4),
//                             Expanded(
//                               child: Text(
//                                 'Location: ${widget.location}',
//                                 style: const TextStyle(fontSize: 16, color: Colors.black),
//                                 softWrap: true,
//                                 overflow: TextOverflow.visible,
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 8),
//                         Text(
//                           widget.price,
//                           style: const TextStyle(
//                             color: Color(0xFF179a3a),
//                             fontSize: 16,
//                           ),
//                         ),
//                         const SizedBox(height: 12),
//                         Text(
//                           widget.description,
//                           style: const TextStyle(fontSize: 14, color: Colors.black87),
//                         ),
//
//                         // const SizedBox(height: 12),
//                         // Text(
//                         //   widget.description,
//                         //   style: const TextStyle(fontSize: 14, color: Colors.black87),
//                         // ),
//
//                         const SizedBox(height: 16),
//
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             IconButton(
//                               onPressed: () {
//                                 final shareText = '''
// 🏠 *${widget.propertyName}*
// 📍 Location: ${widget.location}
// 💰 Price: ${widget.price}
//
// Check out this amazing property!
// 🔗 Visit: https://madanvasu.in/new/
//                                 ''';
//                                 Share.share(shareText);
//                               },
//                               icon: const Icon(Icons.share, color: Color(0xFFe57c42)),
//                               tooltip: 'Share',
//                             ),
//
//                             ElevatedButton(
//                               onPressed: () async {
//                                 final contactController = Get.put(ContactController());
//                                 await contactController.fetchContactDetails();
//
//                                 bool showShareOptions = false;
//
//                                 showDialog(
//                                   context: Get.context!,
//                                   builder: (_) => StatefulBuilder(
//                                     builder: (context, setState) {
//                                       return AlertDialog(
//                                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//                                         title: Text(
//                                           showShareOptions ? 'Share Options' : 'Contact Details',
//                                           style: const TextStyle(
//                                             fontSize: 18,
//                                             fontWeight: FontWeight.bold,
//                                             color: Color(0xFFe57c42),
//                                           ),
//                                         ),
//                                         content: showShareOptions
//                                             ? share_options(
//                                           phoneNumber: contactController.mobileNumber.value,
//                                           email: contactController.emailId.value,
//                                           onBack: () {
//                                             setState(() => showShareOptions = false);
//                                           },
//                                         )
//                                             : Column(
//                                           mainAxisSize: MainAxisSize.min,
//                                           children: [
//                                             InkWell(
//                                               onTap: () {
//                                                 setState(() => showShareOptions = true);
//                                               },
//                                               onLongPress: () {
//                                                 Clipboard.setData(ClipboardData(text: contactController.mobileNumber.value));
//                                                 Get.snackbar("Copied", "Number copied to clipboard");
//                                               },
//                                               child: Row(
//                                                 children: [
//                                                   const Icon(Icons.phone, color: Color(0xFFe57c42)),
//                                                   const SizedBox(width: 8),
//                                                   Text(contactController.mobileNumber.value, style: const TextStyle(fontSize: 16)),
//                                                 ],
//                                               ),
//                                             ),
//                                             const SizedBox(height: 12),
//                                             InkWell(
//                                               onTap: () {
//                                                 final email = contactController.emailId.value;
//                                                 final Uri emailUri = Uri(scheme: 'mailto', path: email);
//                                                 launchUrl(emailUri, mode: LaunchMode.platformDefault).catchError((e) {
//                                                   Get.snackbar('Error', 'Could not open email');
//                                                 });
//                                               },
//                                               onLongPress: () {
//                                                 Clipboard.setData(ClipboardData(text: contactController.emailId.value));
//                                                 Get.snackbar("Copied", "Email copied to clipboard");
//                                               },
//                                               child: Row(
//                                                 children: [
//                                                   const Icon(Icons.email, color: Color(0xFFe57c42)),
//                                                   const SizedBox(width: 8),
//                                                   Text(contactController.emailId.value, style: const TextStyle(fontSize: 16)),
//                                                 ],
//                                               ),
//                                             ),
//                                             const SizedBox(height: 12),
//                                             InkWell(
//                                               onLongPress: () {
//                                                 Clipboard.setData(ClipboardData(text: contactController.address.value.replaceAll(RegExp(r'<[^>]*>'), '')));
//                                                 Get.snackbar("Copied", "Address copied to clipboard");
//                                               },
//                                               child: Row(
//                                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                                 children: [
//                                                   const Icon(Icons.location_on, color: Color(0xFFe57c42)),
//                                                   const SizedBox(width: 8),
//                                                   Expanded(
//                                                     child: Text(
//                                                       contactController.address.value.replaceAll(RegExp(r'<[^>]*>'), ''),
//                                                       style: const TextStyle(fontSize: 16),
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                         actions: [
//                                           if (showShareOptions)
//                                             TextButton(
//                                               onPressed: () {
//                                                 setState(() => showShareOptions = false);
//                                               },
//                                               child: const Text('Back'),
//                                             ),
//                                           TextButton(
//                                             onPressed: () => Navigator.pop(context),
//                                             child: const Text('Close'),
//                                           ),
//                                         ],
//                                       );
//                                     },
//                                   ),
//                                 );
//                               },
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: const Color(0xFFe57c42),
//                               ),
//                               child: const Text(
//                                 "Contact",
//                                 style: TextStyle(color: Colors.white),
//                               ),
//                             ),
//
//                             // IconButton(
//                             //   onPressed: handleFavoriteTap,
//                             //   icon: const Icon(Icons.favorite_border, color: Color(0xFFe57c42)),
//                             //   tooltip: 'Like',
//                             // ),
//
//                             favoriteController != null
//                                 ? Obx(() => IconButton(
//                               icon: Icon(
//                                 favoriteController!.isFavorite(widget.id)
//                                     ? Icons.favorite
//                                     : Icons.favorite_border,
//                               ),
//                               color: const Color(0xFFe57c42),
//                               onPressed: handleFavoriteTap,
//                             ))
//                                 : IconButton(
//                               icon: const Icon(Icons.favorite_border),
//                               color: const Color(0xFFe57c42),
//                               onPressed: handleFavoriteTap,
//                             ),
//
//                           ],
//                         ),
//
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   buildTabButton("Overview", 0),
//                   // buildTabButton("Highlights", 1),
//                   buildTabButton("Reviews", 1),
//                 ],
//               ),
//             ),
//
//             if (selectedTab == 0)
//               SizedBox(
//                 height: 500,
//                 child: PropertyView(propertyId: widget.id),
//               ),
//
//             // FutureBuilder<PropertyDetails?>(
//               //   future: propertyDetailsFuture,
//               //   builder: (context, snapshot) {
//               //     if (snapshot.connectionState == ConnectionState.waiting) {
//               //       return const Padding(
//               //         padding: EdgeInsets.all(20),
//               //         child: CircularProgressIndicator(),
//               //       );
//               //     } else if (snapshot.hasError) {
//               //       return Padding(
//               //         padding: const EdgeInsets.all(20),
//               //         child: Text('Error: ${snapshot.error}'),
//               //       );
//               //     } else if (!snapshot.hasData || snapshot.data == null) {
//               //       return const Padding(
//               //         padding: EdgeInsets.all(20),
//               //         child: Text('No property data available.'),
//               //       );
//               //     } else {
//               //       return buildOverviewTab(snapshot.data!);
//               //     }
//               //   },
//               // ),
//             if (selectedTab == 1)
//               SizedBox(
//                 height: 500,
//                 child: CommentsSection(propertyId: widget.id),
//               ),
//
// // ElevatedButton(onPressed: (){
// //   // Somewhere in your app, push or navigate to this screen:
// //   Navigator.push(
// //     context,
// //     MaterialPageRoute(
// //       builder: (_) => PropertyView(propertyId: widget.id),
// //
// //     ),
// //   );
// //
// // }, child: Text('data'))
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget buildTabButton(String label, int index) {
//     return TextButton(
//       onPressed: () => setState(() => selectedTab = index),
//       child: Text(
//         label,
//         style: TextStyle(
//           fontWeight: FontWeight.bold,
//           fontSize: 16,
//           color: selectedTab == index ? const Color(0xFFe4b201) : Colors.black54,
//          // decoration: selectedTab == index ? TextDecoration.underline : TextDecoration.none,
//         ),
//       ),
//     );
//   }
//
//   Widget buildOverviewTab(PropertyDetails property) {
//
//     // print("------ Property Details ------");
//     // print("Property Name: ${property.title ?? '-'}");
//     // print("Price: ${property.price ?? '-'}");
//     // print("Property Size: ${property.totalArea ?? '-'} Sq Ft");
//     // print("Bedrooms: ${property.bedrooms ?? '-'}");
//     // print("Bathrooms: ${property.bathrooms ?? '-'}");
//     // print("Garage: ${property.parking ?? '-'}");
//     // print("Garage Size: ${property.builtupArea ?? '-'} Sq Ft");
//     // print("Year Built: ${property.transactionDate ?? '-'}");
//     // print("Property Type: ${property.propertyFor ?? '-'}");
//     // print("Property Status: ${property.propertyStatusId ?? '-'}");
//     //
//     // print("------ Additional Details ------");
//     // print("Deposit: ${property.bookingAmount ?? '-'}");
//     // print("Pool Size: ${property.floorPlanArea ?? '-'} Sqft");
//     // print("Last Remodel Year: ${property.lastUpdatedDateTime ?? '-'}");
//     // print("Amenities: ${property.floorPlanDescription ?? '-'}");
//     // print("Additional Rooms: ${property.floorPlanTitle ?? '-'}");
//
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//       child: Container(
//         width: double.infinity,
//         padding: const EdgeInsets.all(20),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(24),
//           border: Border.all(color: const Color(0xFFe4b201), width: 1.8),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.05),
//               blurRadius: 12,
//               offset: const Offset(0, 6),
//             ),
//           ],
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               "Property Details",
//               style: TextStyle(
//                 fontSize: 22,
//                 fontWeight: FontWeight.bold,
//                 color: const Color(0xFFe4b201),
//                 letterSpacing: 0.5,
//               ),
//             ),
//             const SizedBox(height: 14),
//             DetailRow(label: "Property Name ", value: property.title ?? "-"),
//             DetailRow(label: "Price", value: property.price ?? "-"),
//             DetailRow(label: "Property Size", value: "${property.totalArea ?? '-'} Sq Ft"),
//             DetailRow(label: "Bedrooms", value: property.bedrooms ?? "-"),
//             DetailRow(label: "Bathrooms", value: property.bathrooms ?? "-"),
//             DetailRow(label: "Garage", value: property.parking ?? "-"),
//             DetailRow(label: "Garage Size", value: "${property.builtupArea ?? '-'} Sq Ft"),
//             DetailRow(label: "Year Built", value: property.transactionDate ?? "-"),
//             DetailRow(label: "Property Type", value: property.propertyFor ?? "-"),
//             DetailRow(label: "Property Status", value: property.propertyStatusId ?? "-"),
//             const SizedBox(height: 22),
//             Text(
//               "Additional Details",
//               style: TextStyle(
//                 fontSize: 22,
//                 fontWeight: FontWeight.bold,
//                 color: const Color(0xFFe4b201),
//                 letterSpacing: 0.5,
//               ),
//             ),
//             const SizedBox(height: 14),
//             DetailRow(label: "Deposit", value: "${property.bookingAmount ?? '-'}"),
//             DetailRow(label: "Pool Size", value: "${property.floorPlanArea ?? '-'} Sqft"),
//             DetailRow(label: "Last Remodel Year", value: property.lastUpdatedDateTime ?? "-"),
//             DetailRow(label: "Amenities", value: property.floorPlanDescription ?? "-"),
//             DetailRow(label: "Additional Rooms", value: property.floorPlanTitle ?? "-"),
//           ],
//         ),
//       ),
//     );
//   }
//
//   // Widget buildHighlightsTab() {
//   //   return Padding(
//   //     padding: const EdgeInsets.symmetric(horizontal: 10),
//   //     child: Container(
//   //       width: double.infinity,
//   //       padding: const EdgeInsets.all(16),
//   //       decoration: BoxDecoration(
//   //         color: Colors.white,
//   //         borderRadius: BorderRadius.circular(30),
//   //         border: Border.all(color: const Color(0xFFe4b201), width: 1.5),
//   //       ),
//   //       child: const Column(
//   //         crossAxisAlignment: CrossAxisAlignment.start,
//   //         children: [
//   //           Text(
//   //             "Nearby Landmarks",
//   //             style: TextStyle(
//   //               fontSize: 20,
//   //               fontWeight: FontWeight.bold,
//   //               color: Color(0xFFe4b201),
//   //             ),
//   //           ),
//   //           SizedBox(height: 10),
//   //           DetailRow(label: "School", value: "Sunrise Public School - 500m"),
//   //           DetailRow(label: "Hospital", value: "City Care Hospital - 1.2km"),
//   //           DetailRow(label: "Supermarket", value: "Reliance Mart - 800m"),
//   //           DetailRow(label: "Park", value: "Greenview Park - 400m"),
//   //           DetailRow(label: "Metro Station", value: "Sector 21 Metro - 1.5km"),
//   //         ],
//   //       ),
//   //     ),
//   //   );
//   // }
// }

/////balu

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:madhanvasu_app/Feature-based/property_details/property_details_controller.dart';
import 'package:madhanvasu_app/Feature-based/property_details/property_details_widget.dart';
import 'package:share_plus/share_plus.dart';
import 'package:translator/translator.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data/Api_services/user_api_services.dart';
import '../../utils/Common_buttons&widgets/AppLoding_widget.dart';
import '../../utils/Common_buttons&widgets/Custom_bottom_sheet.dart';
import '../../utils/Common_buttons&widgets/share_option.dart';
import '../../utils/shared_pref_helper.dart';
import '../Contact_Us/Contact_us_controller.dart';
import '../../app/configuration/themes/app_colors.dart';
import '../Reviews/All_Reviews_list/comments_screen.dart';
import '../SavedProperties/saved_properties_controller.dart';
import 'Property_details_model.dart';

class PropertyDetailsScreen extends StatefulWidget {
  final String id;
  final String propertyName;
  final String location;
  final String price;
  final String description;

  const PropertyDetailsScreen({
    super.key,
    required this.id,
    required this.propertyName,
    required this.location,
    required this.price,
    required this.description,
  });

  @override
  State<PropertyDetailsScreen> createState() => _PropertyDetailsScreenState();
}

class _PropertyDetailsScreenState extends State<PropertyDetailsScreen> {
  int selectedTab = 0;
  final controller = Get.put(PropertyController());
  PropertyDetailsModel? propertyDetailsModel;
  String? userId;
  final favoriteController = Get.put(FavoritePropertiesController(ApiService()));

  @override
  void initState() {
    super.initState();
    loadUserId();
    controller.fetchPropertyDetails(widget.id);
  }

  Future<void> loadUserId() async {
    final id = await SharedPrefHelper.getUserData('id');
    setState(() {
      userId = id;
    });
  }

  Future<void> handleFavoriteTap() async {
    if (userId == null || userId!.isEmpty) {
      Get.snackbar(
        'Error',
        'Please login to manage favorites',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (widget.id.isEmpty) {
      Get.snackbar(
        'Error',
        'Invalid property ID',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    try {
      final isFav = favoriteController!.isFavorite(widget.id);

      if (isFav) {
        final success = await favoriteController!.removeFavorite(widget.id);
        if (success) {
          Get.snackbar(
            'Removed',
            'Property removed from favorites',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.orange,
            colorText: Colors.white,
          );
        } else {
          Get.snackbar(
            'Error',
            'Failed to remove favorite',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      } else {
        final result = await ApiService.addFavoriteProperty(
          userId: userId!,
          propertyId: widget.id,
        );

        if (result['status'] == true) {
          favoriteController!.favoriteIds.add(widget.id);
          Get.snackbar(
            'Success',
            result['message'] ?? 'Added to favorites',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
        } else if ((result['message'] ?? '').contains('Already Added')) {
          Get.snackbar(
            'Info',
            result['message'] ?? 'Property already in favorites',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.blueGrey,
            colorText: Colors.white,
          );
        } else {
          Get.snackbar(
            'Error',
            result['message'] ?? 'Failed to add favorite',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      }
    } catch (e) {
      print('Favorite error: $e');
      Get.snackbar(
        'Error',
        'Something went wrong',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Widget buildTabButton(String text, int index) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          selectedTab = index;
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: selectedTab == index ? const Color(0xFFe57c42) : Colors.grey[300],
        foregroundColor: selectedTab == index ? Colors.white : Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Text(text),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFDE7),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFFe57c42)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Property Details',
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: const IconThemeData(color: Color(0xFFe57c42)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.only(top: 10),
                child: Card(
                  elevation: 3,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  margin: EdgeInsets.zero,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFFe4b201), width: 1.5),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.propertyName,
                          style: const TextStyle(
                            color: Color(0xFFe4b201),
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(Icons.location_on, color: Color(0xFFe57c42)),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                'Location: ${widget.location}',
                                style: const TextStyle(fontSize: 16, color: Colors.black),
                                softWrap: true,
                                overflow: TextOverflow.visible,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          widget.price,
                          style: const TextStyle(
                            color: Color(0xFF179a3a),
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          widget.description,
                          style: const TextStyle(fontSize: 14, color: Colors.black87),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () {
                                final shareText = '''
🏠 *${widget.propertyName}*
📍 Location: ${widget.location}
💰 Price: ${widget.price}

Check out this amazing property!
🔗 Visit: https://madanvasu.in/new/
                                ''';
                                Share.share(shareText);
                              },
                              icon: const Icon(Icons.share, color: Color(0xFFe57c42)),
                              tooltip: 'Share',
                            ),
                            ElevatedButton(
                              onPressed: () {
                                bool showShareOptions = false;
                                showDialog(
                                  context: Get.context!,
                                  builder: (_) => StatefulBuilder(
                                    builder: (context, setState) {
                                      return AlertDialog(
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                        title: Text(
                                          showShareOptions ? 'Share Options' : 'Contact Details',
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFFe57c42),
                                          ),
                                        ),
                                        content: Obx(() {
                                          final property = controller.propertyDetailsModel.value?.propertyDetails?.first;
                                          if (controller.isLoading.value) {
                                            return const Center(child: CircularProgressIndicator());
                                          }
                                          if (controller.errorMessage.value.isNotEmpty) {
                                            return Text('Error: ${controller.errorMessage.value}');
                                          }
                                          if (property == null) {
                                            return const Text('No contact details available.');
                                          }
                                          return Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              if (showShareOptions)
                                                share_options(
                                                  phoneNumber: property.personNumber ?? '',
                                                  email: '',
                                                  onBack: () {
                                                    setState(() => showShareOptions = false);
                                                  },
                                                )
                                              else ...[
                                                if (property.personName != null)
                                                  Row(
                                                    children: [
                                                      const Icon(Icons.person, color: Color(0xFFe57c42)),
                                                      const SizedBox(width: 8),
                                                      Text(
                                                        property.personName ?? 'N/A',
                                                        style: const TextStyle(fontSize: 16),
                                                      ),
                                                    ],
                                                  ),
                                                const SizedBox(height: 12),
                                                if (property.personNumber != null)
                                                  InkWell(
                                                    onTap: () {
                                                      final phone = property.personNumber ?? '';
                                                      final Uri phoneUri = Uri(scheme: 'tel', path: phone);
                                                      launchUrl(phoneUri, mode: LaunchMode.platformDefault).catchError((e) {
                                                        Get.snackbar('Error', 'Could not make call');
                                                        return true;
                                                      });
                                                    },
                                                    onLongPress: () {
                                                      Clipboard.setData(ClipboardData(text: property.personNumber ?? ''));
                                                      Get.snackbar("Copied", "Number copied to clipboard");
                                                    },
                                                    child: Row(
                                                      children: [
                                                        const Icon(Icons.phone, color: Color(0xFFe57c42)),
                                                        const SizedBox(width: 8),
                                                        Text(
                                                          property.personNumber ?? 'N/A',
                                                          style: const TextStyle(fontSize: 16),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                              ],
                                            ],
                                          );
                                        }),
                                        actions: [
                                          if (showShareOptions)
                                            TextButton(
                                              onPressed: () {
                                                setState(() => showShareOptions = false);
                                              },
                                              child: const Text('Back'),
                                            ),
                                          TextButton(
                                            onPressed: () => Navigator.pop(context),
                                            child: const Text('Close'),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFe57c42),
                              ),
                              child: const Text(
                                "Contact",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            favoriteController != null
                                ? Obx(() => IconButton(
                              icon: Icon(
                                favoriteController!.isFavorite(widget.id) ? Icons.favorite : Icons.favorite_border,
                              ),
                              color: const Color(0xFFe57c42),
                              onPressed: handleFavoriteTap,
                            ))
                                : IconButton(
                              icon: const Icon(Icons.favorite_border),
                              color: const Color(0xFFe57c42),
                              onPressed: handleFavoriteTap,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  buildTabButton("Overview", 0),
                  buildTabButton("Reviews", 1),
                ],
              ),
            ),
            if (selectedTab == 0)
              SizedBox(
                height: 500,
                child: PropertyView(propertyId: widget.id),
              ),
            if (selectedTab == 1)
              SizedBox(
                height: 500,
                child: CommentsSection(propertyId: widget.id),
              ),
          ],
        ),
      ),
    );
  }
}

class DetailRow extends StatelessWidget {
  final String label;
  final String value;
  const DetailRow({super.key, required this.label, required this.value});

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
              style: const TextStyle(fontWeight: FontWeight.w500, color: Colors.black87),
            ),
          ),
          Expanded(
            flex: 5,
            child: Text(
              value,
              style: const TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}


////////////Balu



void showCallOptions(String phoneNumber, String email) {
  Get.defaultDialog(
    title: "Contact Options",
    radius: 10,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    titleStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Choose how you'd like to contact:\n$phoneNumber",
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 15),
        ),
        const SizedBox(height: 16),

        share_options(
          phoneNumber: phoneNumber,
          email: email,
        ),

        const SizedBox(height: 12),
        TextButton(
          onPressed: () => Get.back(),
          child: const Text(
            "Close",
            style: TextStyle(color: AppColors.secondary),
          ),
        ),
      ],
    ),
  );
}


// Future<void> launchCaller(String number) async {
//   final Uri url = Uri(scheme: 'tel', path: number);
//   try {
//     if (!await launchUrl(url)) {
//       throw 'Could not launch dialer';
//     }
//   } catch (e) {
//     Get.snackbar("Error", "$e");
//   }
// }
//
// Future<void> launchSms(String number) async {
//   final Uri url = Uri(scheme: 'sms', path: number);
//   try {
//     if (!await launchUrl(url)) {
//       throw 'Could not send SMS';
//     }
//   } catch (e) {
//     Get.snackbar("Error", "$e");
//   }
// }
//
// Future<void> launchWhatsApp(String number) async {
//   final Uri url = Uri.parse("https://wa.me/$number");
//   try {
//     if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
//       throw 'Could not open WhatsApp';
//     }
//   } catch (e) {
//     Get.snackbar("Error", "$e");
//   }
// }
//
// Future<void> launchEmail(String email) async {
//   final Uri url = Uri(scheme: 'mailto', path: email);
//   try {
//     if (!await launchUrl(url)) {
//       throw 'Could not open email';
//     }
//   } catch (e) {
//     Get.snackbar("Error", "$e");
//   }
// }



///////////Balu