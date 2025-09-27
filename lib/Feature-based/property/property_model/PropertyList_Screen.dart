// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
// import 'package:madhanvasu_app/Feature-based/property/property_model/property_controller.dart';
// import 'package:madhanvasu_app/Feature-based/property/property_model/property_model.dart';
// import 'package:provider/provider.dart';
//
// import '../../../app/configuration/ themes/app_colors.dart';
// import '../../../utils/Common_buttons&widgets/AppLoding_widget.dart';
// import '../../categorys/categorys_controller/categorys_controller.dart';
//
//
// class PropertyListScreen extends StatelessWidget {
//   const PropertyListScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     // GetX controller
//     final categoryController = Get.find<CategoryController>();
//
//     // Provider controller
//     final propertyController = Provider.of<PropertyController>(context, listen: false);
//
//     // Fetch all properties once after build
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       if (categoryController.categories.isNotEmpty) {
//         final firstCategoryId = categoryController.categories.first.id;
//         propertyController.fetchProperties(firstCategoryId);
//       }
//     });
//
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Propertieseeeeee'),
//       ),
//       body: Column(
//         children: [
//           // Category List - using GetX controller
//           Obx(() {
//             if (categoryController.isLoading.value) {
//               return const Center(child: CustomLoader());
//             }
//             return SizedBox(
//               height: 80,
//               child: ListView.builder(
//                 scrollDirection: Axis.horizontal,
//                 itemCount: categoryController.categories.length,
//                 itemBuilder: (context, index) {
//                   final category = categoryController.categories[index];
//                   return Container(
//                     width: 110,
//                     margin: const EdgeInsets.symmetric(horizontal: 8),
//                     decoration: BoxDecoration(
//                       color: AppColors.primary.withOpacity(0.9),
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     alignment: Alignment.center,
//                     child: GestureDetector(
//                       onTap: () {
//                         // Call fetchProperties with selected category.id
//                         propertyController.fetchProperties(category.id);
//                       },
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text(
//                             category.propertyCategoryTitle,
//                             style: const TextStyle(
//                               color: AppColors.backgroundColor,
//                               fontSize: 18,
//                               fontWeight: FontWeight.w500,
//                             ),
//                             textAlign: TextAlign.center,
//                           ),
//                           Text(
//                             category.id,
//                             style: const TextStyle(
//                               color: AppColors.backgroundColor,
//                               fontSize: 14,
//                               fontWeight: FontWeight.w400,
//                             ),
//                             textAlign: TextAlign.center,
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             );
//           }),
//
//           // Property List
//           Expanded(
//             child: Consumer<PropertyController>(
//               builder: (context, controller, child) {
//                 if (controller.isLoading) {
//                   return const Center(child: CircularProgressIndicator());
//                 }
//
//                 if (controller.errorMessage != null) {
//                   return Center(child: Text('Error: ${controller.errorMessage}'));
//                 }
//
//                 ////////// Balu
//
//                 final properties = controller.propertiesData?.data?.properties
//                     ?.where((prop) => prop.propertyCatId == controller.selectedCategoryId)
//                     .toList();
//
//                 /////////Balu
//
//                 if (properties == null || properties.isEmpty) {
//                   return const Center(child: Text('No properties found'));
//                 }
//
//                 return ListView.builder(
//                   padding: const EdgeInsets.all(8.0),
//                   itemCount: properties.length,
//                   itemBuilder: (context, index) {
//                     return PropertyCard(property: properties[index]);
//                   },
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// // Property Card Widget
// class PropertyCard extends StatelessWidget {
//   final Properties property;
//
//   const PropertyCard({Key? key, required this.property}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: const EdgeInsets.symmetric(vertical: 8.0),
//       child: ListTile(
//         title: Text(
//           property.title ?? 'No Title',
//           style: const TextStyle(fontWeight: FontWeight.bold),
//         ),
//         subtitle: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('Price: ${property.price ?? 'N/A'}'),
//
//             Text('Location: ${property.streetName ?? 'N/A'}, ${property.pinCode ?? 'N/A'}'),
//
//             Text('Area: ${property.totalArea ?? 'N/A'}'), //propertyCatId
//
//             Text('categories : ${property.propertyCatId ?? 'N/A'}'),    //propertyCatId
//
//           ],
//         ),
//         trailing: const Icon(Icons.arrow_forward_ios),
//         onTap: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => PropertyDetailsScreen(property: property),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
//
// // Property Details Screen
// class PropertyDetailsScreen extends StatelessWidget {
//   final Properties property;
//
//   const PropertyDetailsScreen({Key? key, required this.property}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(property.title ?? 'Property Details'),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             if (property.propertyImage != null)
//               Image.network(
//                 property.propertyImage!,
//                 height: 200,
//                 width: double.infinity,
//                 fit: BoxFit.cover,
//                 errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
//               ),
//             const SizedBox(height: 16),
//             Text('Title: ${property.title ?? 'N/A'}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             const SizedBox(height: 8),
//             Text('Price: ${property.price ?? 'N/A'}'),
//             Text('Location: ${property.streetName ?? 'N/A'}, ${property.pinCode ?? 'N/A'}'),
//             Text('Total Area: ${property.totalArea ?? 'N/A'}'),
//             Text('Bedrooms: ${property.bedrooms ?? 'N/A'}'),
//             Text('Bathrooms: ${property.bathrooms ?? 'N/A'}'),
//             Text('Parking: ${property.parking ?? 'N/A'}'),
//             Text('Property Description: ${property.propertyDesc ?? 'N/A'}'),
//             Text('Contact: ${property.personName ?? 'N/A'} (${property.personNumber ?? 'N/A'})'),
//             Text('RERA Number: ${property.reraNumber ?? 'N/A'}'),
//             Text('Facing Direction: ${property.facingDirection ?? 'N/A'}'),
//             Text('Added Date: ${property.addedDateTime ?? 'N/A'}'),
//             const SizedBox(height: 16),
//             const Text('Location Details:', style: TextStyle(fontWeight: FontWeight.bold)),
//             Text('Latitude: ${property.latitude ?? 'N/A'}'),
//             Text('Longitude: ${property.longitude ?? 'N/A'}'),
//           ],
//         ),
//       ),
//     );
//   }
// }