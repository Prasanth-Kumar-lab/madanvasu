// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:madhanvasu_app/Feature-based/SavedProperties/saved_properties_model.dart';
//
// import '../../app/configuration/ themes/app_colors.dart';
// import '../bottam_nav/bottam_navbar_screen.dart';
//
// class FavoritePropertiesScreen extends StatefulWidget {
//   @override
//   _FavoritePropertiesScreenState createState() =>
//       _FavoritePropertiesScreenState();
// }
//
// class _FavoritePropertiesScreenState extends State<FavoritePropertiesScreen> {
//   late Future<FavoritePropertiesResponse> _futureFavorites;
//   int _selectedIndex = 1;
//
//   @override
//   void initState() {
//     super.initState();
//     _futureFavorites = fetchFavoriteProperties();
//   }
//
//   Future<FavoritePropertiesResponse> fetchFavoriteProperties() async {
//     var headers = {
//       'Cookie': 'ci_session=3802ff23a50e93a76844d3fee7cdeb3c34d0c66c',
//     };
//
//     var request = http.Request(
//       'GET',
//       Uri.parse(
//           'https://madanvasu.in/new/apis/Api_favorite_properties/user_favorite_properties_list?user_id=53'),
//     );
//
//     request.headers.addAll(headers);
//     http.StreamedResponse response = await request.send();
//
//     if (response.statusCode == 200) {
//       String jsonString = await response.stream.bytesToString();
//       Map<String, dynamic> jsonMap = json.decode(jsonString);
//       return FavoritePropertiesResponse.fromJson(jsonMap);
//     } else {
//       throw Exception('Failed to load data: ${response.reasonPhrase}');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         backgroundColor: AppColors.secondary.withOpacity(0.8),
//         elevation: 1,
//         centerTitle: true,
//         title: Text(
//           'Saved Properties',
//           style: TextStyle(
//             color: Colors.black,
//             fontSize: 22,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         iconTheme: IconThemeData(color: Color(0xFFe57c42)),
//       ),
//
//       body: FutureBuilder<FavoritePropertiesResponse>(
//         future: _futureFavorites,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text("Error: ${snapshot.error}"));
//           } else if (!snapshot.hasData ||
//               snapshot.data!.data?.favoriteProperties == null ||
//               snapshot.data!.data!.favoriteProperties!.isEmpty) {
//             return const Center(child: Text("No favorite properties found."));
//           }
//
//           List<FavoriteProperty> properties =
//           snapshot.data!.data!.favoriteProperties!;
//
//           return ListView.builder(
//             padding: const EdgeInsets.all(16),
//             itemCount: properties.length,
//             itemBuilder: (context, index) {
//               final property = properties[index];
//               return _buildSavedCard(
//                 context: context,
//                 title: property.title ?? 'No Title',
//                 location: property.streetName ?? 'Unknown Location',
//                 price: property.price ?? 'N/A',
//                 type: property.propertyFor ?? 'N/A',
//                 area: property.totalArea ?? 'N/A',
//               );
//             },
//           );
//         },
//       ),
//       bottomNavigationBar: CustomBottomNavigationBar(
//         currentIndex: _selectedIndex,
//         toggleTheme: () {},
//         primaryColor: AppColors.secondary,
//         bottomNavbarColor: AppColors.primary,
//         cardColor: AppColors.backgroundColor,
//       ),
//     );
//   }
//
//   Widget _buildSavedCard({
//     required BuildContext context,
//     required String title,
//     required String location,
//     required String price,
//     required String type,
//     required String area,
//   }) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(color: AppColors.secondary, width: 1.5),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 6,
//             offset: const Offset(0, 3),
//           ),
//         ],
//       ),
//       child: InkWell(
//         borderRadius: BorderRadius.circular(16),
//         onTap: () {
//           // Navigate to detail screen (optional)
//         },
//         child: Padding(
//           padding: const EdgeInsets.all(16),
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       title,
//                       style: const TextStyle(
//                         fontWeight: FontWeight.bold,
//                         color: AppColors.secondary,
//                         fontSize: 18,
//                       ),
//                       maxLines: 2,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                     const SizedBox(height: 6),
//                     Row(
//                       children: [
//                         const Icon(Icons.location_on, size: 16, color: Colors.red),
//                         const SizedBox(width: 4),
//                         Expanded(
//                           child: Text(
//                             location,
//                             style: TextStyle(
//                               color: Colors.black.withOpacity(0.6),
//                               fontSize: 14,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 6),
//                     Row(
//                       children: [
//                         const Icon(Icons.home, size: 16, color: AppColors.primary),
//                         const SizedBox(width: 4),
//                         Text(
//                           type,
//                           style: TextStyle(
//                             color: Colors.black.withOpacity(0.6),
//                             fontSize: 14,
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 8),
//                     Row(
//                       children: [
//                         const Icon(Icons.square_foot, size: 16, color: Colors.green),
//                         const SizedBox(width: 4),
//                         Text(
//                           area,
//                           style: TextStyle(
//                             color: Colors.black.withOpacity(0.6),
//                             fontSize: 14,
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 8),
//                     Text(
//                       price,
//                       style: const TextStyle(
//                         fontWeight: FontWeight.bold,
//                         color: Colors.green,
//                         fontSize: 16,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const Padding(
//                 padding: EdgeInsets.only(top: 110),
//                 child: Icon(Icons.favorite, color: Colors.red, size: 28),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }



/////////////////////////


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:madhanvasu_app/Feature-based/SavedProperties/saved_properties_controller.dart';
import 'package:madhanvasu_app/Feature-based/SavedProperties/saved_properties_model.dart';
import '../../app/configuration/ themes/app_colors.dart';
import '../../utils/Common_buttons&widgets/AppLoding_widget.dart';
import '../bottam_nav/bottam_navbar_screen.dart';
import '../property_details/property_details.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';


class FavoritePropertiesScreen extends StatefulWidget {
  final Color primaryColor;
  final Color accentColor;
  final Color cardColor;
  final Color secondaryTextColor;

  const FavoritePropertiesScreen({
    Key? key,
    required this.primaryColor,
    required this.accentColor,
    required this.cardColor,
    required this.secondaryTextColor,
  }) : super(key: key);

  @override
  _FavoritePropertiesScreenState createState() => _FavoritePropertiesScreenState();
}

class _FavoritePropertiesScreenState extends State<FavoritePropertiesScreen> {
  final FavoritePropertiesController controller = Get.put(
      FavoritePropertiesController(Get.find()));

  final int _selectedIndex = 1;

  final RefreshController _refreshController = RefreshController();

  @override
  void initState() {
    super.initState();

    // Trigger refresh on screen load
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(Duration(milliseconds: 200), () async {
        await controller.refreshFavorites();
        if (mounted) {
          _refreshController.requestRefresh(); // Now it's safe
          _refreshController.refreshCompleted();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,

        backgroundColor: widget.cardColor,

        // backgroundColor: AppColors.primary.withOpacity(0.9),
        elevation: 1,
        centerTitle: true,
        title: const Text(
          'Saved Properties',
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Color(0xFFe57c42)),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CustomLoader());
        } else if (controller.error.isNotEmpty) {
          return Center(child: Text("Error: ${controller.error.value}"));
        } else if (controller.favoriteProperties.isEmpty) {
          return const Center(child: Text("No favorite properties found."));
        }

        return SmartRefresher(
          controller: _refreshController,
          onRefresh: () async {
            await controller.refreshFavorites();
            _refreshController.refreshCompleted();
          },
          header: CustomHeader(
            builder: (context, mode) {
              if (mode == RefreshStatus.idle) {
                return const SizedBox();
              } else if (mode == RefreshStatus.refreshing) {
                return const Center(child: CustomLoader());
              } else if (mode == RefreshStatus.failed) {
                return const Center(child: Text("Refresh failed"));
              } else if (mode == RefreshStatus.canRefresh) {
                return const Center(child: Text("Release to refresh"));
              } else {
                return const SizedBox();
              }
            },
          ),
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: controller.favoriteProperties.length,
            itemBuilder: (context, index) {
              final property = controller.favoriteProperties[index];
              return _buildSavedCard(
                context: context,
                property: property,
              );
            },
          ),
        );
      }),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _selectedIndex,
        toggleTheme: () {},
        primaryColor: AppColors.secondary,
        bottomNavbarColor: AppColors.primary,
        cardColor: AppColors.backgroundColor,
      ),
    );
  }

  Widget _buildSavedCard({
    required BuildContext context,
    required FavoriteProperty property,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PropertyDetailsScreen(
              id: property.id ?? '',
              propertyName: property.title ?? '',
              location: property.streetName ?? '',
              price: property.price != null ? '₹${property.price}' : '',
              description: property.floorPlanDescription ?? 'No description available',
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.secondary, width: 1.2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              property.title ?? 'No Title',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.secondary,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 6),

            // Location
            Row(
              children: [
                const Icon(Icons.location_on, size: 16, color: Colors.red),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    property.streetName ?? 'Unknown Location',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.black.withOpacity(0.6),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),

            // Property Type & Area
            Row(
              children: [
                const Icon(Icons.home, size: 16, color: AppColors.primary),
                const SizedBox(width: 4),
                Text(
                  property.propertyFor ?? 'N/A',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.black.withOpacity(0.6),
                  ),
                ),
                const SizedBox(width: 12),
                const Icon(Icons.square_foot, size: 16, color: Colors.green),
                const SizedBox(width: 4),
                Text(
                  property.totalArea ?? 'N/A',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.black.withOpacity(0.6),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            // Price
            Text(
              property.price ?? 'N/A',
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),

            const SizedBox(height: 12),

            // View Details + Favorite
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Same navigation as container tap
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PropertyDetailsScreen(
                          id: property.id ?? '',
                          propertyName: property.title ?? '',
                          location: property.streetName ?? '',
                          price: property.price != null ? '₹${property.price}' : '',
                          description: property.floorPlanDescription ?? 'No description available',
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFe57c42),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'View Details',
                    style: TextStyle(fontSize: 13, color: Colors.white),
                  ),
                ),

                Obx(() {
                  final isFav = controller.isFavorite(property.id ?? '');
                  return GestureDetector(
                    onTap: () async {
                      final confirmed = await showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Remove Favorite'),
                          content: const Text('Are you sure you want to remove this property from favorites?'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context, false),
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(context, true),
                              child: const Text('Remove', style: TextStyle(color: Colors.red)),
                            ),
                          ],
                        ),
                      );
                      if (confirmed == true && property.id != null) {
                        await controller.removeFavorite(property.id!);
                      }
                    },
                    child: Icon(
                      Icons.favorite,
                      size: 24,
                      color: isFav ? Colors.redAccent : Colors.grey[400],
                    ),
                  );
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }


}


