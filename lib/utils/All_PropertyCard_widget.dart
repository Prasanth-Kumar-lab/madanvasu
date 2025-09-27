// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
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
//       height: 200,
//       width: isHorizontal ? 260 : double.infinity,
//       margin: EdgeInsets.only(right: isHorizontal ? 8 : 0),
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
//         padding: const EdgeInsets.only(left:15, top: 10, right: 10, bottom: 0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//
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
//             // SizedBox(height: 30,),
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



//////////////////////////


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:madhanvasu_app/utils/shared_pref_helper.dart';
import '../Feature-based/SavedProperties/saved_properties_controller.dart';
import '../data/Api_services/user_api_services.dart';
import 'Common_buttons&widgets/AppLoding_widget.dart';

class PropertyCard extends StatefulWidget {
  final String title;
  final String price;
  final String location;
  final bool isHorizontal;
  final Color primaryColor;
  final Color accentColor;
  final Color cardColor;
  final Color secondaryTextColor;
  final VoidCallback onViewDetails;
  final String propertyId;

  const PropertyCard({
    super.key,
    required this.title,
    required this.price,
    required this.location,
    required this.isHorizontal,
    required this.primaryColor,
    required this.accentColor,
    required this.cardColor,
    required this.secondaryTextColor,
    required this.onViewDetails,
    required this.propertyId,
  });

  @override
  State<PropertyCard> createState() => _PropertyCardState();
}

class _PropertyCardState extends State<PropertyCard> {
  FavoritePropertiesController? favoriteController;
  String? userId;

  @override
  void initState() {
    super.initState();
    // Initialize or get existing controller with proper error handling
    try {
      if (Get.isRegistered<FavoritePropertiesController>()) {
        favoriteController = Get.find<FavoritePropertiesController>();
      } else {
        // Ensure ApiService is available
        if (!Get.isRegistered<ApiService>()) {
          Get.put(ApiService());
        }
        favoriteController = Get.put(FavoritePropertiesController(Get.find<ApiService>()));
      }
    } catch (e) {
      print('Error initializing FavoritePropertiesController: $e');
      // Fallback: create controller without dependency injection
      favoriteController = FavoritePropertiesController(ApiService());
    }
    loadUserId();
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

    if (widget.propertyId.isEmpty) {
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
      final isFav = favoriteController!.isFavorite(widget.propertyId);

      if (isFav) {
        // Remove from favorites
        final success = await favoriteController!.removeFavorite(widget.propertyId);
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
        // Add to favorites
        final result = await ApiService.addFavoriteProperty(
          userId: userId!,
          propertyId: widget.propertyId,
        );

        // Assuming API returns a response like {"status":true, "message":"..."}
        if (result['status'] == true) {
          favoriteController!.favoriteIds.add(widget.propertyId); // Update UI
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

  @override
  Widget build(BuildContext context) {
    return userId == null
        ? const Center(child: CustomLoader())
        : Container(
      height: 150,
      width: widget.isHorizontal ? 260 : double.infinity,
      margin: EdgeInsets.only(right: widget.isHorizontal ? 8 : 0),
      decoration: BoxDecoration(
        color: widget.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: widget.primaryColor, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: widget.primaryColor.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 15, top: 10, right: 10, bottom: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title and location with view details button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: widget.primaryColor,
                          letterSpacing: 0.2,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        widget.location,
                        style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 14,
                          letterSpacing: 0.2,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: widget.onViewDetails,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFe57c42),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    minimumSize: const Size(0, 40),
                  ),
                  child: const Text(
                    'View Details',
                    style: TextStyle(fontSize: 12, color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            // Price and favorite button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.price,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: widget.accentColor,
                    fontSize: 16,
                    letterSpacing: 0.3,
                  ),
                ),
                // Use conditional rendering for the favorite button
                favoriteController != null
                    ? Obx(() => IconButton(
                  icon: Icon(
                    favoriteController!.isFavorite(widget.propertyId)
                        ? Icons.favorite
                        : Icons.favorite_border,
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
    );
  }
}


