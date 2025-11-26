import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:madhanvasu_app/Feature-based/home/Rented_properties/Rented_properties_controller.dart';
import 'package:madhanvasu_app/Feature-based/property_details/property_details.dart';
import '../../../utils/shared_pref_helper.dart';
import '../../Notifications/Notification_controller.dart';
import '../../bottam_nav/bottam_navbar_screen.dart';
import '../../categorys/category_widget/category_widget_view.dart';
import '../../categorys/categorys_controller/categorys_controller.dart';
import '../Available_properties/Available_properties_controller.dart';
import '../Available_properties/Available_properties_screen.dart';
import '../Available_properties/Available_properties_widget.dart';
import '../FeaturedPoperties/Featured_properties_screen.dart';
import '../FeaturedPoperties/featured_PropertiesController.dart';
import '../FeaturedPoperties/featured_properties_widget.dart';
import '../../userlocation_map/LocationController.dart';
import '../../../app/configuration/themes/app_colors.dart';
import '../Rented_properties/Rented_propertieList_screen.dart';
import '../Rented_properties/Rented_properties_widget.dart';
import '../Sold_properties/sold_properties_controller.dart';
import '../Sold_properties/sold_properties_screen.dart';
import '../Sold_properties/sold_properties_widget.dart';

// Property Card Widget
class PropertyCard extends StatelessWidget {
  final String title;
  final String price;
  final String location;
  final bool isHorizontal;
  final Color primaryColor;
  final Color accentColor;
  final Color cardColor;
  final Color secondaryTextColor;
  final VoidCallback onViewDetails;

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
    // required String propertyFor, ///Balu
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170,
      width: isHorizontal ? 220 : double.infinity,
      margin: EdgeInsets.only(right: isHorizontal ? 12 : 0, bottom: 10), // Added bottom margin
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: primaryColor, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: primaryColor.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: primaryColor,
                letterSpacing: 0.2,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 2),
            Text(
              location,
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 14,
                letterSpacing: 0.2,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            Text(
              price,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: accentColor,
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
                    onPressed: onViewDetails,
                    child: Card(
                      color: const Color(0xFFe57c42),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
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
                IconButton(
                  icon: const Icon(Icons.favorite_border),
                  color: const Color(0xFFe57c42),
                  onPressed: () {

                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Search Bar Widget
class SearchBarWidget extends StatelessWidget {
  final Color primaryColor;
  final Color cardColor;
  final Color secondaryTextColor;
  final Color bottomNavbar;
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;

  const SearchBarWidget({
    super.key,
    required this.primaryColor,
    required this.cardColor,
    required this.secondaryTextColor,
    required this.bottomNavbar,
    required this.controller,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: primaryColor, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: primaryColor.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: StatefulBuilder(
        builder: (context, setState) {
          return TextField(
            controller: controller,
            onChanged: (value) {
              setState(() {});
              if (onChanged != null) {
                onChanged!(value);
              }
            },
            decoration: InputDecoration(
              hintText: 'Search properties, neighborhoods, or keywords',
              hintStyle: TextStyle(color: secondaryTextColor, fontSize: 16),
              prefixIcon: Icon(Icons.search, color: bottomNavbar, size: 24),
              suffixIcon: controller.text.isNotEmpty
                  ? GestureDetector(
                onTap: () {
                  controller.clear();
                  setState(() {});
                  if (onChanged != null) {
                    onChanged!('');
                  }
                },
                child: Icon(Icons.clear, color: secondaryTextColor, size: 20),
              )
                  : null,
              filled: true,
              fillColor: Colors.transparent,
              contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: primaryColor, width: 1.5),
              ),
            ),
          );
        },
      ),
    );
  }
}

class SectionHeaderWidget extends StatelessWidget {
  final String title;
  final Color bottomNavbar;

  const SectionHeaderWidget({
    super.key,
    required this.title,
    required this.bottomNavbar,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            letterSpacing: 0.3,
          ),
        ),
        Icon(Icons.arrow_forward_ios, size: 23, color: bottomNavbar),
      ],
    );
  }
}

class RealEstateHomeScreen extends StatefulWidget {
  const RealEstateHomeScreen({super.key});

  @override
  State<RealEstateHomeScreen> createState() => _RealEstateHomeScreenState();
}

class _RealEstateHomeScreenState extends State<RealEstateHomeScreen> {
  int _selectedIndex = 0;
  final Color primaryColor = AppColors.secondary;
  final Color accentColor = AppColors.accentColor;
  final Color backgroundColor = AppColors.backgroundColor;
  final Color cardColor = Colors.white;
  final Color secondaryTextColor = AppColors.secondaryTextColor;
  final Color bottomNavbar = AppColors.primary;

  final controller = Get.put(CategoryController());
  final LocationController locationController = Get.put(LocationController());

  List<Widget> get _screens => [
    HomeTab(
      primaryColor: primaryColor,
      accentColor: accentColor,
      backgroundColor: backgroundColor,
      cardColor: cardColor,
      secondaryTextColor: secondaryTextColor,
      bottomNavbar: bottomNavbar,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [backgroundColor, backgroundColor],
          ),
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: _screens[_selectedIndex],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _selectedIndex,
        toggleTheme: () {},
        primaryColor: AppColors.secondary,
        bottomNavbarColor: AppColors.primary,
        cardColor: AppColors.backgroundColor,
      ),
    );
  }
}

class HomeTab extends StatefulWidget {
  final Color primaryColor;
  final Color accentColor;
  final Color backgroundColor;
  final Color cardColor;
  final Color secondaryTextColor;
  final Color bottomNavbar;

  const HomeTab({
    super.key,
    required this.primaryColor,
    required this.accentColor,
    required this.backgroundColor,
    required this.cardColor,
    required this.secondaryTextColor,
    required this.bottomNavbar,
  });

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  late final TextEditingController _searchController;
  final RxString _searchText = ''.obs;
  final RxBool _showSearchResults = false.obs;
  final CategoryController categoryController = Get.put(CategoryController());

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();

    _searchController.addListener(() {
      _searchText.value = _searchController.text.toLowerCase().trim();
      _showSearchResults.value = _searchController.text.isNotEmpty;

      SharedPrefHelper.getUserData('villageName').then((village) {
        debugPrint(' villageName from SharedPrefs: $village');
      });

      SharedPrefHelper.getUserData('mandalName').then((mandal) {
        debugPrint(' mandalName from SharedPrefs: $mandal');
      });

      SharedPrefHelper.getUserData('districtName').then((district) {
        debugPrint(' districtName from SharedPrefs: $district');
      });

      SharedPrefHelper.getUserData('stateName').then((state) {
        debugPrint('stateName from SharedPrefs: $state');
      });

      printUserData();

    });
  }

  void printUserData() async {
    final id = await SharedPrefHelper.getUserData('id');
    final personName = await SharedPrefHelper.getUserData('personName');
    final villageName = await SharedPrefHelper.getUserData('villageName');
    final mandalName = await SharedPrefHelper.getUserData('mandalName');
    final districtName = await SharedPrefHelper.getUserData('districtName');
    final stateName = await SharedPrefHelper.getUserData('stateName');

    debugPrint(' ID: $id');
    debugPrint('Nameeeeeeeeeeeeeeeee: $personName');
    debugPrint(' Village: $villageName');
    debugPrint(' Mandal: $mandalName');
    debugPrint(' District: $districtName');
    debugPrint(' State: $stateName');
  }


  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Widget _buildSearchResults() {
    final propertiesController = Get.find<PropertiesController>();
    final availableController = Get.find<Available_PropertiesController>();
    final rentedController = Get.find<Rented_PropertiesController>();
    final soldController = Get.find<SoldPropertiesController>();

    return Obx(() {
      if (_searchText.isEmpty) {
        return const SizedBox.shrink();
      }

      final allProperties = [
        ...(propertiesController.propertiesList.value ?? []),
        ...(availableController.propertiesList.value ?? []),
        ...(rentedController.propertiesList.value ?? []),
        ...(soldController.propertiesList.value ?? []),
      ];

      final filteredProperties = allProperties.where((property) {
        final title = property.title?.toLowerCase() ?? '';
        final price = property.price?.toString() ?? '';
        final description = property.floorPlanDescription?.toLowerCase() ?? '';
        final streetName = property.streetName?.toLowerCase() ?? '';
        final pinCode = property.pinCode?.toLowerCase() ?? '';

        String villageName = '';
        String mandalName = '';
        String districtName = '';

        if (propertiesController.villagesList.isNotEmpty && property.villageId != null) {
          villageName = propertiesController.villagesList
              .firstWhereOrNull((v) => v.id == property.villageId)?.name?.toLowerCase() ?? '';
        }

        if (propertiesController.mandalsList.isNotEmpty && property.mandalId != null) {
          mandalName = propertiesController.mandalsList
              .firstWhereOrNull((m) => m.id == property.mandalId)?.name?.toLowerCase() ?? '';
        }

        if (propertiesController.districtsList.isNotEmpty && property.districtId != null) {
          districtName = propertiesController.districtsList
              .firstWhereOrNull((d) => d.id == property.districtId)?.name?.toLowerCase() ?? '';
        }

        final query = _searchText.value;

        return title.contains(query) ||
            price.contains(query) ||
            description.contains(query) ||
            streetName.contains(query) ||
            pinCode.contains(query) ||
            villageName.contains(query) ||
            mandalName.contains(query) ||
            districtName.contains(query);
      }).toList();

      if (filteredProperties.isEmpty) {
        return const Center(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Text('No properties found matching your search.'),
          ),
        );
      }

      return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(vertical: 10),
        itemCount: filteredProperties.length,
        itemBuilder: (context, index) {
          final property = filteredProperties[index];

          String villageName = '';
          String mandalName = '';

          if (propertiesController.villagesList.isNotEmpty && property.villageId != null) {
            villageName = propertiesController.villagesList
                .firstWhereOrNull((v) => v.id == property.villageId)?.name ?? '';
          }

          if (propertiesController.mandalsList.isNotEmpty && property.mandalId != null) {
            mandalName = propertiesController.mandalsList
                .firstWhereOrNull((m) => m.id == property.mandalId)?.name ?? '';
          }

          final location = [
            property.streetName?.trim() ?? '',
            villageName.trim(),
            mandalName.trim(),
            property.pinCode?.trim() ?? '',
          ].where((e) => e.isNotEmpty).join(', ');

          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: PropertyCard(
              title: property.title ?? 'N/A',
              // propertyFor:property.propertyFor ?? '',
              // price: property.price != null ? '₹${property.price} / month' : 'N/A',
              price: property.price != null
                  ? '₹${property.price}${property.propertyFor == 'Rent' ? ' / month' : ''}'
                  : 'N/A',

              location: location,
              isHorizontal: false,
              primaryColor: widget.primaryColor,
              accentColor: widget.accentColor,
              cardColor: widget.cardColor,
              secondaryTextColor: widget.secondaryTextColor,
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
            ),
          );
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final CategoryController controller = Get.find<CategoryController>();
    final locationController = Get.put(LocationController());
    final notificationController = Get.put(NotificationController());

    Get.put(LocationController()).getCurrentLocation();
    // Get.put(NotificationController()).fetchUnreadCount();/////Balu
    final propertiesController = Get.put(PropertiesController());
    final availableController = Get.put(Available_PropertiesController());
    final rentedController = Get.put(Rented_PropertiesController());
    final soldController = Get.put(SoldPropertiesController());


    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
        if (didPop) {}
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: AppBar(
            elevation: 0,
            automaticallyImplyLeading: false,
            titleSpacing: 0,
            backgroundColor: Colors.white,
            title: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Image.asset(
                    'assets/App_logo.png',
                    height: 40,
                    width: 40,
                    fit: BoxFit.contain,
                  ),
                ),

                /*const Spacer(),

                FutureBuilder<String?>(
                  future: SharedPrefHelper.getUserData('personName'),
                  builder: (context, snapshot) {
                    final personName = snapshot.data ?? '';
                    final initial = personName.isNotEmpty ? personName[0].toUpperCase() : '?';

                    return Text('$personName', style: TextStyle(fontWeight: FontWeight.bold),);
                  },
                ),
                const Spacer(),*/
                const Spacer(),
            ShaderMask(
              shaderCallback: (bounds) {
                return const LinearGradient(
                  colors: [
                    Color(0xFFFFEB3B),
                    Color(0xFFFF9800),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ).createShader(bounds);
              },
              child: Text(
                'Madanvasu',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Important! Needed for shader mask
                ),
              ),
            )
             //shimmer only when page loads
                .animate()
                .shimmer(
              duration: 1500.ms,
              color: Colors.white,
            ),
            const Spacer(),
                FutureBuilder<String?>(
                  future: SharedPrefHelper.getUserData('personName'),
                  builder: (context, snapshot) {
                    final personName = snapshot.data ?? '';
                    final initial = personName.isNotEmpty ? personName[0].toUpperCase() : '?';
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed('/profile');
                      },
                      child: Padding(
                          padding: const EdgeInsets.only(right: 16, left: 8),
                          child: /*Text(
                          '$initial',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),*/
                          /*Container(
                          width: 40, // Circle width
                          height: 40, // Circle height
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [Colors.blue, Colors.purple], // Gradient colors
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              initial,
                              style: TextStyle(
                                color: Colors.white, // Make it visible on gradient
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ).animate(onPlay: (controller) => controller.repeat()).shimmer(
                          duration: 2000.ms,
                          color: Colors.white,)*/
                          Icon(Icons.person_pin, size: 40, color: Colors.deepOrange.shade300,).animate(onPlay: (controller) => controller.repeat()).shimmer(
                            duration: 2000.ms,
                            color: Colors.white,)
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),


        ///////////////////////////////////////////

        // appBar: AppBar(
        //   // backgroundColor: widget.cardColor,
        //   // backgroundColor: AppColors.secondary.withOpacity(0.8),
        //
        //   elevation: 0,
        //   title: FutureBuilder(
        //     future: Future.wait([
        //       SharedPrefHelper.getUserData('villageName'),
        //       SharedPrefHelper.getUserData('mandalName'),
        //     ]),
        //     builder: (context, AsyncSnapshot<List<String?>> snapshot) {
        //       if (!snapshot.hasData) {
        //         return const Text('Loading location...');
        //       }
        //
        //       final village = snapshot.data![0] ?? 'Village';
        //       final mandal = snapshot.data![1] ?? 'Mandal';
        //
        //       return GestureDetector(
        //         onTap: () {
        //           locationController.selectLocationFromMap(context);
        //         },
        //         child: Text(
        //           '$village, $mandal',
        //           style: const TextStyle(
        //             color: Colors.black,
        //             fontWeight: FontWeight.bold,
        //             fontSize: 18,
        //             letterSpacing: 0.5,
        //           ),
        //         ),
        //       );
        //     },
        //   ),
        //   centerTitle: false,
        //   leading: FutureBuilder<String?>(
        //     future: SharedPrefHelper.getUserData('personName'),
        //     builder: (context, snapshot) {
        //       final personName = snapshot.data ?? '';
        //       final initial = personName.isNotEmpty ? personName[0].toUpperCase() : '?';
        //
        //       return GestureDetector(
        //         onTap: () {
        //           Get.toNamed('/profile');
        //         },
        //         child: Padding(
        //           padding: const EdgeInsets.only(left: 16),
        //           child: CircleAvatar(
        //             backgroundColor: const Color(0xFFe57c42).withOpacity(0.8),
        //             child: Text(
        //               initial,
        //               style: const TextStyle(
        //                 color: Colors.white,
        //                 fontSize: 20,
        //                 fontWeight: FontWeight.bold,
        //               ),
        //             ),
        //           ),
        //         ),
        //       );
        //     },
        //   ),
        //   actions: [
        //     CircleAvatar(
        //       radius: 15,
        //       child: Image.asset(
        //         'assets/App_logo.png',
        //         height: 50,
        //         width: 50,
        //       ),
        //     ),
        //     const SizedBox(width: 8),
        //   ],
        // ),


        ////////////////////////////////////////////



        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     final LocationController locationController = Get.put(LocationController());
        //     locationController.selectLocationFromMap(context);
        //   },
        //   backgroundColor: widget.bottomNavbar,
        //   child: const Icon(Icons.my_location, color: Colors.white),
        // ),

        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [widget.backgroundColor, widget.backgroundColor],
            ),
          ),
          child: Padding(
            // padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            padding: const EdgeInsets.symmetric(horizontal:6),

            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SearchBarWidget(
                    primaryColor: widget.primaryColor,
                    cardColor: widget.cardColor,
                    secondaryTextColor: widget.secondaryTextColor,
                    bottomNavbar: widget.bottomNavbar,
                    controller: _searchController,
                    onChanged: (query) {
                    },
                  ),
                  const SizedBox(height: 8),

                  Obx(() => _showSearchResults.value ? _buildSearchResults() : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      // SizedBox(
                      //   // color: Colors.white,
                      //   height: 100,
                      //   width: MediaQuery.of(context).size.width,
                      //   child: CategoryScreen(),
                      // ),


                      Container(
                        color: Colors.white,
                        height: 100,
                        width: MediaQuery.of(context).size.width,
                        child: const CategoryScreen(),
                      ),

                      const SizedBox(height: 2),
                      GestureDetector(
                        onTap: () {
                          Get.to(() => Properties_listScreen(
                            title: 'Under Construction Properties',
                            primaryColor: widget.primaryColor,
                            accentColor: widget.accentColor,
                            cardColor: widget.cardColor,
                            secondaryTextColor: widget.secondaryTextColor,
                            backgroundColor: widget.cardColor,
                            bottomNavbar: widget.bottomNavbar,
                          ));
                        },
                        child: SectionHeaderWidget(
                          title: 'Under Construction Properties',
                          bottomNavbar: widget.bottomNavbar,
                        ),
                      ),
                      const SizedBox(height: 2),
                      SizedBox(
                        height: 150,
                        width: MediaQuery.of(context).size.width,
                        child: PropertiesView(
                          primaryColor: widget.primaryColor,
                          accentColor: widget.accentColor,
                          cardColor: widget.cardColor,
                          secondaryTextColor: widget.secondaryTextColor,
                        ),
                      ),
                      const SizedBox(height: 2),
                      GestureDetector(
                        onTap: () {
                          Get.to(() => AvailablePropertyListScreen(
                            title: 'Available Properties',
                            primaryColor: widget.primaryColor,
                            accentColor: widget.accentColor,
                            cardColor: widget.cardColor,
                            secondaryTextColor: widget.secondaryTextColor,
                            backgroundColor: widget.cardColor,
                            bottomNavbar: widget.bottomNavbar,
                          ));
                        },
                        child: SectionHeaderWidget(
                          title: 'Available Properties',
                          bottomNavbar: widget.bottomNavbar,
                        ),
                      ),
                      SizedBox(
                        height: 150,
                        width: MediaQuery.of(context).size.width,
                        child: Builder(
                          builder: (context) {
                            if (!Get.isRegistered<Available_PropertiesController>()) {
                              Get.put(Available_PropertiesController());
                            }
                            return AvailableProperties(
                              primaryColor: widget.primaryColor,
                              accentColor: widget.accentColor,
                              cardColor: widget.cardColor,
                              secondaryTextColor: widget.secondaryTextColor,
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 2),
                      GestureDetector(
                        onTap: () {
                          Get.to(() => RentedPropertyListScreen(
                            title: 'Rented Properties',
                            primaryColor: widget.primaryColor,
                            accentColor: widget.accentColor,
                            cardColor: widget.cardColor,
                            secondaryTextColor: widget.secondaryTextColor,
                            backgroundColor: widget.cardColor,
                            bottomNavbar: widget.bottomNavbar,
                          ));
                        },
                        child: SectionHeaderWidget(
                          title: 'Rented Properties',
                          bottomNavbar: widget.bottomNavbar,
                        ),
                      ),
                      SizedBox(
                        height: 150,
                        width: MediaQuery.of(context).size.width,
                        child: Builder(
                          builder: (context) {
                            if (!Get.isRegistered<Rented_PropertiesController>()) {
                              Get.put(Rented_PropertiesController());
                            }
                            return RentedProperties(
                              primaryColor: widget.primaryColor,
                              accentColor: widget.accentColor,
                              cardColor: widget.cardColor,
                              secondaryTextColor: widget.secondaryTextColor,
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 2),
                      GestureDetector(
                        onTap: () {
                          Get.to(() => SoldPropertyListScreen(
                            title: 'Sold Properties',
                            primaryColor: widget.primaryColor,
                            accentColor: widget.accentColor,
                            cardColor: widget.cardColor,
                            secondaryTextColor: widget.secondaryTextColor,
                            backgroundColor: widget.cardColor,
                            bottomNavbar: widget.bottomNavbar,
                          ));
                        },
                        child: SectionHeaderWidget(
                          title: 'Sold Properties',
                          bottomNavbar: widget.bottomNavbar,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height *0.5,
                        width: MediaQuery.of(context).size.width * 100,
                        child: Builder(
                          builder: (context) {
                            if (!Get.isRegistered<SoldPropertiesController>()) {
                              Get.put(SoldPropertiesController());
                            }
                            return SoldProperties(
                              primaryColor: widget.primaryColor,
                              accentColor: widget.accentColor,
                              cardColor: widget.cardColor,
                              secondaryTextColor: widget.secondaryTextColor,
                            );
                          },
                        ),
                      ),
                    ],
                  )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}







// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:madhanvasu_app/Feature-based/home/Rented_properties/Rented_properties_controller.dart';
// import 'package:madhanvasu_app/Feature-based/property_details/property_details.dart';
// import '../../../app/routes/app_pages.dart';
// import '../../../madhanvasu_lib/ui_screens/home_page.dart';
// import '../../../utils/Common_buttons&widgets/AppLoding_widget.dart';
// import '../../../utils/shared_pref_helper.dart';
// import '../../Notifications/Notification_controller.dart';
// import '../../bottam_nav/bottam_navbar_screen.dart';
// import '../../categorys/category_widget/category_widget_view.dart';
// import '../../categorys/categorys_controller/categorys_controller.dart';
// import '../../categorys/categorys_model/categorys_model.dart';
// import '../Available_properties/Available_properties_controller.dart';
// import '../Available_properties/Available_properties_screen.dart';
// import '../Available_properties/Available_properties_widget.dart';
// import '../FeaturedPoperties/FeaturedProperties_model.dart';
// import '../FeaturedPoperties/Featured_properties_screen.dart';
// import '../FeaturedPoperties/featured_PropertiesController.dart';
// import '../FeaturedPoperties/featured_properties_widget.dart';
// import '../../userlocation_map/LocationController.dart';
// import '../../../app/configuration/ themes/app_colors.dart';
// import '../../../madhanvasu_lib/aswini_screens/notification_screen.dart';
// import '../Rented_properties/Rented_propertieList_screen.dart';
// import '../Rented_properties/Rented_properties_widget.dart';
// import '../Sold_properties/sold_properties_controller.dart';
// import '../Sold_properties/sold_properties_screen.dart';
// import '../Sold_properties/sold_properties_widget.dart';
//
// class CategoryModel {
//   final int id;
//   final String name;
//
//   CategoryModel({required this.id, required this.name});
// }
//
//
// class FilterDialog extends StatefulWidget {
//   final List<CategoryModel> categories;
//   final String initialMinPrice;
//   final String initialMaxPrice;
//
//   final List<String> initialSelectedCategories;
//   final Function(double min, double max, List<String> selected) onApply;
//
//   const FilterDialog({
//     super.key,
//     required this.categories,
//     required this.initialMinPrice,
//     required this.initialMaxPrice,
//     required this.initialSelectedCategories,
//     required this.onApply,
//   });
//
//   @override
//   State<FilterDialog> createState() => _FilterDialogState();
// }
//
// class _FilterDialogState extends State<FilterDialog> {
//   late RangeValues selectedRange;
//   late List<bool> checked;
//   bool selectAll = false;
//
//   final double minPriceLimit = 1000;
//   final double maxPriceLimit = 1000000000;
//
//   @override
//   void initState() {
//     super.initState();
//
//     double start = double.tryParse(widget.initialMinPrice) ?? minPriceLimit;
//     start = start.clamp(minPriceLimit, maxPriceLimit);
//
//     double end = double.tryParse(widget.initialMaxPrice) ?? maxPriceLimit;
//     end = end.clamp(minPriceLimit, maxPriceLimit);
//
//     selectedRange = RangeValues(start, end);
//
//     checked = widget.categories
//         .map((c) => widget.initialSelectedCategories.contains(c.name))
//         .toList();
//
//     selectAll = checked.every((b) => b);
//   }
//
//   void clearFilters() {
//     setState(() {
//       selectedRange = RangeValues(minPriceLimit, maxPriceLimit);
//       checked = List.generate(checked.length, (_) => false);
//       selectAll = false;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: const Text('Filters'),
//       content: SingleChildScrollView(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text('Price Range', style: TextStyle(fontWeight: FontWeight.bold)),
//             const SizedBox(height: 8),
//             RangeSlider(
//               values: selectedRange,
//               min: minPriceLimit,
//               max: maxPriceLimit,
//               divisions: 100,
//               labels: RangeLabels(
//                 selectedRange.start.round().toString(),
//                 selectedRange.end.round().toString(),
//               ),
//               onChanged: (values) {
//                 setState(() {
//                   selectedRange = values;
//                 });
//               },
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 12),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text('Min: ${selectedRange.start.toStringAsFixed(0)}'),
//                   Text('Max: ${selectedRange.end.toStringAsFixed(0)}'),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 16),
//             const Text('Categories', style: TextStyle(fontWeight: FontWeight.bold)),
//             CheckboxListTile(
//               title: const Text('Select All'),
//               value: selectAll,
//               controlAffinity: ListTileControlAffinity.leading,
//               onChanged: (val) {
//                 setState(() {
//                   selectAll = val ?? false;
//                   checked = List.generate(checked.length, (_) => selectAll);
//                 });
//               },
//             ),
//             SizedBox(
//               height: 200,
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: List.generate(widget.categories.length, (index) {
//                     return CheckboxListTile(
//                       title: Text(widget.categories[index].name),
//                       value: checked[index],
//                       controlAffinity: ListTileControlAffinity.leading,
//                       onChanged: (val) {
//                         setState(() {
//                           checked[index] = val ?? false;
//                           selectAll = checked.every((b) => b);
//                         });
//                       },
//                     );
//                   }),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//       actions: [
//         TextButton(
//           onPressed: clearFilters,
//           child: const Text('Clear Filters'),
//         ),
//         TextButton(
//           onPressed: () => Navigator.pop(context),
//           child: const Text('Cancel'),
//         ),
//         ElevatedButton(
//           onPressed: () {
//             final min = selectedRange.start;
//             final max = selectedRange.end;
//             final selectedCategories = <String>[];
//             for (int i = 0; i < checked.length; i++) {
//               if (checked[i]) selectedCategories.add(widget.categories[i].name);
//             }
//             widget.onApply(min, max, selectedCategories);
//             Navigator.pop(context);
//           },
//           child: const Text('Apply'),
//         ),
//       ],
//     );
//   }
// }
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
//       margin: EdgeInsets.only(right: isHorizontal ? 12 : 0, bottom: 10), // Added bottom margin
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
// class SearchBarWidget extends StatelessWidget {
//   final Color primaryColor;
//   final Color cardColor;
//   final Color secondaryTextColor;
//   final Color bottomNavbar;
//   final TextEditingController controller;
//   final ValueChanged<String>? onChanged;
//   final VoidCallback? onFilterPressed;
//
//   const SearchBarWidget({
//     super.key,
//     required this.primaryColor,
//     required this.cardColor,
//     required this.secondaryTextColor,
//     required this.bottomNavbar,
//     required this.controller,
//     this.onChanged,
//     this.onFilterPressed,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: cardColor,
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: primaryColor, width: 1.5),
//         boxShadow: [
//           BoxShadow(
//             color: primaryColor.withOpacity(0.05),
//             blurRadius: 8,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: StatefulBuilder(
//         builder: (context, setState) {
//           return TextField(
//             controller: controller,
//             onChanged: (value) {
//               setState(() {}); // Rebuild to show/hide clear icon
//               if (onChanged != null) {
//                 onChanged!(value);
//               }
//             },
//             decoration: InputDecoration(
//               hintText: 'Search properties, neighborhoods, or keywords',
//               hintStyle: TextStyle(color: secondaryTextColor, fontSize: 16),
//               prefixIcon: Icon(Icons.search, color: bottomNavbar, size: 24),
//               suffix: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   if (controller.text.isNotEmpty)
//                     GestureDetector(
//                       onTap: () {
//                         controller.clear();
//                         setState(() {}); // Refresh to hide icon after clearing
//                         if (onChanged != null) {
//                           onChanged!('');
//                         }
//                       },
//                       child: Icon(Icons.clear, color: secondaryTextColor, size: 20),
//                     ),
//                   if (controller.text.isNotEmpty) const SizedBox(width: 8),
//                   GestureDetector(
//                     onTap: onFilterPressed,
//                     child: Icon(Icons.filter_list, color: bottomNavbar, size: 24),
//                   ),
//                   const SizedBox(width: 16), // Padding from the end
//                 ],
//               ),
//               filled: true,
//               fillColor: Colors.transparent,
//               contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(12),
//                 borderSide: BorderSide.none,
//               ),
//               enabledBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(12),
//                 borderSide: BorderSide.none,
//               ),
//               focusedBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(12),
//                 borderSide: BorderSide(color: primaryColor, width: 1.5),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
//
// class SectionHeaderWidget extends StatelessWidget {
//   final String title;
//   final Color bottomNavbar;
//
//   const SectionHeaderWidget({
//     super.key,
//     required this.title,
//     required this.bottomNavbar,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           title,
//           style: const TextStyle(
//             fontSize: 22,
//             fontWeight: FontWeight.bold,
//             color: Colors.black,
//             letterSpacing: 0.3,
//           ),
//         ),
//         Icon(Icons.arrow_forward_ios, size: 23, color: bottomNavbar),
//       ],
//     );
//   }
// }
//
// class RealEstateHomeScreen extends StatefulWidget {
//   const RealEstateHomeScreen({super.key});
//
//   @override
//   State<RealEstateHomeScreen> createState() => _RealEstateHomeScreenState();
// }
//
// class _RealEstateHomeScreenState extends State<RealEstateHomeScreen> {
//   int _selectedIndex = 0;
//   final Color primaryColor = AppColors.secondary;
//   final Color accentColor = AppColors.accentColor;
//   final Color backgroundColor = AppColors.backgroundColor;
//   final Color cardColor = Colors.white;
//   final Color secondaryTextColor = AppColors.secondaryTextColor;
//   final Color bottomNavbar = AppColors.primary;
//
//   final controller = Get.put(CategoryController());
//   final LocationController locationController = Get.put(LocationController());
//
//   List<Widget> get _screens => [
//     HomeTab(
//       primaryColor: primaryColor,
//       accentColor: accentColor,
//       backgroundColor: backgroundColor,
//       cardColor: cardColor,
//       secondaryTextColor: secondaryTextColor,
//       bottomNavbar: bottomNavbar,
//     ),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [backgroundColor, backgroundColor],
//           ),
//         ),
//         child: AnimatedSwitcher(
//           duration: const Duration(milliseconds: 300),
//           child: _screens[_selectedIndex],
//         ),
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
// }
//
// class HomeTab extends StatefulWidget {
//   final Color primaryColor;
//   final Color accentColor;
//   final Color backgroundColor;
//   final Color cardColor;
//   final Color secondaryTextColor;
//   final Color bottomNavbar;
//
//   const HomeTab({
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
//   State<HomeTab> createState() => _HomeTabState();
// }
//
// class _HomeTabState extends State<HomeTab> {
//   late final TextEditingController _searchController;
//   final RxString _searchText = ''.obs;
//   final RxBool _showSearchResults = false.obs;
//   final RxDouble _minPrice = 0.0.obs;
//   final RxDouble _maxPrice = double.infinity.obs;
//   final RxList<String> _selectedCategories = <String>[].obs;
//
//   @override
//   void initState() {
//     super.initState();
//     _searchController = TextEditingController();
//
//     _searchController.addListener(() {
//       _searchText.value = _searchController.text.toLowerCase().trim();
//       _showSearchResults.value = _searchText.isNotEmpty ||
//           _minPrice.value > 0 ||
//           _maxPrice.value < double.infinity ||
//           _selectedCategories.isNotEmpty;
//
//       SharedPrefHelper.getUserData('villageName').then((village) {
//         debugPrint('🧭 villageName from SharedPrefs: $village');
//       });
//
//       SharedPrefHelper.getUserData('mandalName').then((mandal) {
//         debugPrint('🧭 mandalName from SharedPrefs: $mandal');
//       });
//
//       SharedPrefHelper.getUserData('districtName').then((district) {
//         debugPrint('🧭 districtName from SharedPrefs: $district');
//       });
//
//       SharedPrefHelper.getUserData('stateName').then((state) {
//         debugPrint('🧭 stateName from SharedPrefs: $state');
//       });
//
//       printUserData();
//     });
//   }
//
//   void printUserData() async {
//     final id = await SharedPrefHelper.getUserData('id');
//     final personName = await SharedPrefHelper.getUserData('personName');
//     final villageName = await SharedPrefHelper.getUserData('villageName');
//     final mandalName = await SharedPrefHelper.getUserData('mandalName');
//     final districtName = await SharedPrefHelper.getUserData('districtName');
//     final stateName = await SharedPrefHelper.getUserData('stateName');
//
//     debugPrint('👤 ID: $id');
//     debugPrint('👤 Nameeeeeeeeeeeeeeeee: $personName');
//     debugPrint('📍 Village: $villageName');
//     debugPrint('📍 Mandal: $mandalName');
//     debugPrint('📍 District: $districtName');
//     debugPrint('📍 State: $stateName');
//   }
//
//   void _showFilterDialog(BuildContext context) {
//     final CategoryController categoryController = Get.find<CategoryController>();
//
//     final List<CategoryModel> categories = categoryController.categories.map((categoryData) {
//       return CategoryModel(
//         id: int.tryParse(categoryData.id ?? '') ?? 0,
//         name: categoryData.propertyCategoryTitle,
//         // Map other necessary fields here
//       );
//     }).toList();
//
//     showDialog(
//       context: context,
//       builder: (context) => FilterDialog(
//         categories: categories,
//         initialMinPrice: _minPrice.value > 0 ? _minPrice.value.toString() : '',
//         initialMaxPrice: _maxPrice.value < double.infinity ? _maxPrice.value.toString() : '',
//         initialSelectedCategories: _selectedCategories.value,
//         onApply: (min, max, selected) {
//           _minPrice.value = min;
//           _maxPrice.value = max;
//           _selectedCategories.value = selected;
//           _showSearchResults.value = _searchText.isNotEmpty ||
//               min > 0 ||
//               max < double.infinity ||
//               selected.isNotEmpty;
//         },
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }
//
//   Widget _buildSearchResults() {
//     final propertiesController = Get.find<PropertiesController>();
//     final availableController = Get.find<Available_PropertiesController>();
//     final rentedController = Get.find<Rented_PropertiesController>();
//     final soldController = Get.find<SoldPropertiesController>();
//
//     return Obx(() {
//       final allProperties = [
//         ...(propertiesController.propertiesList.value ?? []),
//         ...(availableController.propertiesList.value ?? []),
//         ...(rentedController.propertiesList.value ?? []),
//         ...(soldController.propertiesList.value ?? []),
//       ];
//
//       // Filter properties based on search text and filters
//       final filteredProperties = allProperties.where((property) {
//         final title = property.title?.toLowerCase() ?? '';
//         final priceStr = property.price?.toString() ?? '';
//         final description = property.floorPlanDescription?.toLowerCase() ?? '';
//         final streetName = property.streetName?.toLowerCase() ?? '';
//         final pinCode = property.pinCode?.toLowerCase() ?? '';
//
//         // Get location details
//         String villageName = '';
//         String mandalName = '';
//         String districtName = '';
//
//         if (propertiesController.villagesList.isNotEmpty && property.villageId != null) {
//           villageName = propertiesController.villagesList
//               .firstWhereOrNull((v) => v.id == property.villageId)?.name?.toLowerCase() ?? '';
//         }
//
//         if (propertiesController.mandalsList.isNotEmpty && property.mandalId != null) {
//           mandalName = propertiesController.mandalsList
//               .firstWhereOrNull((m) => m.id == property.mandalId)?.name?.toLowerCase() ?? '';
//         }
//
//         if (propertiesController.districtsList.isNotEmpty && property.districtId != null) {
//           districtName = propertiesController.districtsList
//               .firstWhereOrNull((d) => d.id == property.districtId)?.name?.toLowerCase() ?? '';
//         }
//
//         final query = _searchText.value;
//
//         final bool textMatch = title.contains(query) ||
//             priceStr.contains(query) ||
//             description.contains(query) ||
//             streetName.contains(query) ||
//             pinCode.contains(query) ||
//             villageName.contains(query) ||
//             mandalName.contains(query) ||
//             districtName.contains(query);
//
//         final double propPrice = double.tryParse(property.price ?? '') ?? 0.0;
//         final bool priceMatch = propPrice >= _minPrice.value && propPrice <= _maxPrice.value;
//
//         // Assume property has a 'category' field (string); adjust based on actual model
//         final bool categoryMatch = _selectedCategories.isEmpty ||
//             _selectedCategories.contains(property.price ?? '');
//
//         return textMatch && priceMatch && categoryMatch;
//       }).toList();
//
//       if (filteredProperties.isEmpty) {
//         return const Center(
//           child: Padding(
//             padding: EdgeInsets.all(16.0),
//             child: Text('No properties found matching your search.'),
//           ),
//         );
//       }
//
//       return ListView.builder(
//         physics: const NeverScrollableScrollPhysics(),
//         shrinkWrap: true,
//         padding: const EdgeInsets.symmetric(vertical: 10), // Added vertical padding
//         itemCount: filteredProperties.length,
//         itemBuilder: (context, index) {
//           final property = filteredProperties[index];
//
//           // Get location details
//           String villageName = '';
//           String mandalName = '';
//
//           if (propertiesController.villagesList.isNotEmpty && property.villageId != null) {
//             villageName = propertiesController.villagesList
//                 .firstWhereOrNull((v) => v.id == property.villageId)?.name ?? '';
//           }
//
//           if (propertiesController.mandalsList.isNotEmpty && property.mandalId != null) {
//             mandalName = propertiesController.mandalsList
//                 .firstWhereOrNull((m) => m.id == property.mandalId)?.name ?? '';
//           }
//
//           final location = [
//             property.streetName?.trim() ?? '',
//             villageName.trim(),
//             mandalName.trim(),
//             property.pinCode?.trim() ?? '',
//           ].where((e) => e.isNotEmpty).join(', ');
//
//           return Padding(
//             padding: const EdgeInsets.only(bottom: 10), // Added bottom padding for spacing
//             child: PropertyCard(
//               title: property.title ?? 'N/A',
//               price: property.price != null ? '₹${property.price} / month' : 'N/A',
//               location: location,
//               isHorizontal: false,
//               primaryColor: widget.primaryColor,
//               accentColor: widget.accentColor,
//               cardColor: widget.cardColor,
//               secondaryTextColor: widget.secondaryTextColor,
//               onViewDetails: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => PropertyDetailsScreen(
//                       id: property.id ?? '',
//                       propertyName: property.title ?? '',
//                       location: location,
//                       price: property.price != null ? '₹${property.price}' : '',
//                       description: property.floorPlanDescription ?? "No Description",
//                     ),
//                   ),
//                 );
//               },
//             ),
//           );
//         },
//       );
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final CategoryController controller = Get.find<CategoryController>();
//     final locationController = Get.put(LocationController());
//     final notificationController = Get.put(NotificationController());
//
//     Get.put(LocationController()).getCurrentLocation();
//     Get.put(NotificationController()).fetchUnreadCount();
//     final propertiesController = Get.put(PropertiesController());
//     final availableController = Get.put(Available_PropertiesController());
//     final rentedController = Get.put(Rented_PropertiesController());
//     final soldController = Get.put(SoldPropertiesController());
//
//     return PopScope(
//       canPop: true,
//       onPopInvoked: (didPop) {
//         if (didPop) {}
//       },
//       child: Scaffold(
//         appBar: AppBar(
//           backgroundColor: widget.cardColor,
//           elevation: 0,
//           title: FutureBuilder(
//             future: Future.wait([
//               SharedPrefHelper.getUserData('villageName'),
//               SharedPrefHelper.getUserData('mandalName'),
//             ]),
//             builder: (context, AsyncSnapshot<List<String?>> snapshot) {
//               if (!snapshot.hasData) {
//                 return const Text('Loading location...');
//               }
//
//               final village = snapshot.data![0] ?? 'Village';
//               final mandal = snapshot.data![1] ?? 'Mandal';
//
//               return GestureDetector(
//                 onTap: () {
//                   locationController.selectLocationFromMap(context);
//                 },
//                 child: Text(
//                   '$village, $mandal',
//                   style: const TextStyle(
//                     color: Colors.black,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 18,
//                     letterSpacing: 0.5,
//                   ),
//                 ),
//               );
//             },
//           ),
//           centerTitle: false,
//           leading: FutureBuilder<String?>(
//             future: SharedPrefHelper.getUserData('personName'),
//             builder: (context, snapshot) {
//               final personName = snapshot.data ?? '';
//               final initial = personName.isNotEmpty ? personName[0].toUpperCase() : '?';
//
//               return GestureDetector(
//                 onTap: () {
//                   Get.toNamed('/profile');
//                 },
//                 child: Padding(
//                   padding: const EdgeInsets.only(left: 16),
//                   child: CircleAvatar(
//                     backgroundColor: const Color(0xFFe57c42).withOpacity(0.8),
//                     child: Text(
//                       initial,
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ),
//               );
//             },
//           ),
//           actions: [
//             CircleAvatar(
//               radius: 15,
//               child: Image.asset(
//                 'assets/App_logo.png',
//                 height: 50,
//                 width: 50,
//               ),
//             ),
//             const SizedBox(width: 8),
//           ],
//         ),
//
//         floatingActionButton: FloatingActionButton(
//           onPressed: () {
//             final LocationController locationController = Get.put(LocationController());
//             locationController.selectLocationFromMap(context);
//           },
//           backgroundColor: widget.bottomNavbar,
//           child: const Icon(Icons.my_location, color: Colors.white),
//         ),
//         body: Container(
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//               colors: [widget.backgroundColor, widget.backgroundColor],
//             ),
//           ),
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 6),
//             child: SingleChildScrollView(
//               physics: const BouncingScrollPhysics(),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SearchBarWidget(
//                     primaryColor: widget.primaryColor,
//                     cardColor: widget.cardColor,
//                     secondaryTextColor: widget.secondaryTextColor,
//                     bottomNavbar: widget.bottomNavbar,
//                     controller: _searchController,
//                     onChanged: (query) {
//                       // The listener will handle this
//                     },
//                     onFilterPressed: () => _showFilterDialog(context),
//                   ),
//                   const SizedBox(height: 8),
//
//                   // Show search results when searching or filters applied
//                   Obx(() => _showSearchResults.value ? _buildSearchResults() : Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//
//                       Container(
//                         color: Colors.white,
//                         height: 100,
//                         width: MediaQuery.of(context).size.width,
//                         child: const CategoryScreen(),
//                       ),
//
//                       const SizedBox(height: 2),
//                       GestureDetector(
//                         onTap: () {
//                           Get.to(() => Properties_listScreen(
//                             title: 'Under Construction Properties',
//                             primaryColor: widget.primaryColor,
//                             accentColor: widget.accentColor,
//                             cardColor: widget.cardColor,
//                             secondaryTextColor: widget.secondaryTextColor,
//                             backgroundColor: widget.cardColor,
//                             bottomNavbar: widget.bottomNavbar,
//                           ));
//                         },
//                         child: SectionHeaderWidget(
//                           title: 'Under Construction Properties',
//                           bottomNavbar: widget.bottomNavbar,
//                         ),
//                       ),
//                       const SizedBox(height: 2),
//                       SizedBox(
//                         height: 150,
//                         width: MediaQuery.of(context).size.width,
//                         child: PropertiesView(
//                           primaryColor: widget.primaryColor,
//                           accentColor: widget.accentColor,
//                           cardColor: widget.cardColor,
//                           secondaryTextColor: widget.secondaryTextColor,
//                         ),
//                       ),
//                       const SizedBox(height: 2),
//                       GestureDetector(
//                         onTap: () {
//                           Get.to(() => AvailablePropertyListScreen(
//                             title: 'Available Properties',
//                             primaryColor: widget.primaryColor,
//                             accentColor: widget.accentColor,
//                             cardColor: widget.cardColor,
//                             secondaryTextColor: widget.secondaryTextColor,
//                             backgroundColor: widget.cardColor,
//                             bottomNavbar: widget.bottomNavbar,
//                           ));
//                         },
//                         child: SectionHeaderWidget(
//                           title: 'Available Properties',
//                           bottomNavbar: widget.bottomNavbar,
//                         ),
//                       ),
//                       SizedBox(
//                         height: 150,
//                         width: MediaQuery.of(context).size.width,
//                         child: Builder(
//                           builder: (context) {
//                             if (!Get.isRegistered<Available_PropertiesController>()) {
//                               Get.put(Available_PropertiesController());
//                             }
//                             return AvailableProperties(
//                               primaryColor: widget.primaryColor,
//                               accentColor: widget.accentColor,
//                               cardColor: widget.cardColor,
//                               secondaryTextColor: widget.secondaryTextColor,
//                             );
//                           },
//                         ),
//                       ),
//                       const SizedBox(height: 2),
//                       GestureDetector(
//                         onTap: () {
//                           Get.to(() => RentedPropertyListScreen(
//                             title: 'Rented Properties',
//                             primaryColor: widget.primaryColor,
//                             accentColor: widget.accentColor,
//                             cardColor: widget.cardColor,
//                             secondaryTextColor: widget.secondaryTextColor,
//                             backgroundColor: widget.cardColor,
//                             bottomNavbar: widget.bottomNavbar,
//                           ));
//                         },
//                         child: SectionHeaderWidget(
//                           title: 'Rented Properties',
//                           bottomNavbar: widget.bottomNavbar,
//                         ),
//                       ),
//                       SizedBox(
//                         height: 150,
//                         width: MediaQuery.of(context).size.width,
//                         child: Builder(
//                           builder: (context) {
//                             if (!Get.isRegistered<Rented_PropertiesController>()) {
//                               Get.put(Rented_PropertiesController());
//                             }
//                             return RentedProperties(
//                               primaryColor: widget.primaryColor,
//                               accentColor: widget.accentColor,
//                               cardColor: widget.cardColor,
//                               secondaryTextColor: widget.secondaryTextColor,
//                             );
//                           },
//                         ),
//                       ),
//                       const SizedBox(height: 2),
//                       GestureDetector(
//                         onTap: () {
//                           Get.to(() => soldPropertyListScreen(
//                             title: 'Sold Properties',
//                             primaryColor: widget.primaryColor,
//                             accentColor: widget.accentColor,
//                             cardColor: widget.cardColor,
//                             secondaryTextColor: widget.secondaryTextColor,
//                             backgroundColor: widget.cardColor,
//                             bottomNavbar: widget.bottomNavbar,
//                           ));
//                         },
//                         child: SectionHeaderWidget(
//                           title: 'Sold Properties',
//                           bottomNavbar: widget.bottomNavbar,
//                         ),
//                       ),
//                       SizedBox(
//                         height: MediaQuery.of(context).size.height *0.7,
//                         width: MediaQuery.of(context).size.width * 100,
//                         child: Builder(
//                           builder: (context) {
//                             if (!Get.isRegistered<SoldPropertiesController>()) {
//                               Get.put(SoldPropertiesController());
//                             }
//                             return SoldProperties(
//                               primaryColor: widget.primaryColor,
//                               accentColor: widget.accentColor,
//                               cardColor: widget.cardColor,
//                               secondaryTextColor: widget.secondaryTextColor,
//                             );
//                           },
//                         ),
//                       ),
//                     ],
//                   )),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }