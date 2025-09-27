import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';

import '../../../data/Api_services/user_api_services.dart';
import '../../../utils/shared_pref_helper.dart';
import '../../SavedProperties/saved_properties_controller.dart';

class FeaturedPropertyCard extends StatefulWidget {
  final String propertyId;
  final String title;
  final String price;
  final String location;
  final bool isHorizontal;
  final Color primaryColor;
  final Color accentColor;
  final Color cardColor;
  final Color secondaryTextColor;
  final VoidCallback onViewDetails;

  const FeaturedPropertyCard({
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
  State<FeaturedPropertyCard> createState() => _FeaturedPropertyCardState();
}

class _FeaturedPropertyCardState extends State<FeaturedPropertyCard> {
  final favoriteController = Get.put(FavoritePropertiesController(ApiService()));

  // FavoritePropertiesController? favoriteController;

  String? userId;

  @override
  void initState() {
    super.initState();
    loadUserId();
  }

  Future<void> loadUserId() async {
    final id = await SharedPrefHelper.getUserData('id');
    setState(() {
      userId = id;
    });
  }

  // void handleFavoriteTap() async {
  //   if (userId == null) {
  //     print('User ID not available');
  //     return;
  //   }
  //
  //   print('User ID: $userId');
  //   print('Property ID: ${widget.propertyId}');
  //
  //   await ApiService.addFavoriteProperty(
  //     userId: userId!,
  //     propertyId: widget.propertyId,
  //   );
  // }

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
    return Container(
      height: 200,
      width: widget.isHorizontal ? 240 : double.infinity,
      margin: EdgeInsets.only(right: widget.isHorizontal ? 16 : 0, bottom: 16),
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
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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
            const SizedBox(height: 4),
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
            const SizedBox(height: 12),
            Text(
              widget.price,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: widget.accentColor,
                fontSize: 16,
                letterSpacing: 0.3,
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: TextButton(
                    onPressed: widget.onViewDetails,
                    child: Card(
                      color: const Color(0xFFe57c42),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Container(
                        height: 40,
                        width: 120,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: const Text(
                          'View Details',
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),

                // IconButton(
                //   icon: const Icon(Icons.favorite_border),
                //   color: const Color(0xFFe57c42),
                //   onPressed: handleFavoriteTap,
                // ),

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
