// import 'package:flutter/material.dart';
// import 'package:real_estate/ui_screens/post_propertys.dart';
// import 'package:real_estate/ui_screens/profile_page.dart';
// import 'package:real_estate/ui_screens/saved_propertys_ui2.dart';
//
// class RealEstateHomeScreen extends StatefulWidget {
//   const RealEstateHomeScreen({Key? key}) : super(key: key);
//
//   @override
//   State<RealEstateHomeScreen> createState() => _RealEstateHomeScreenState();
// }
//
// class _RealEstateHomeScreenState extends State<RealEstateHomeScreen> {
//   int _selectedIndex = 0;
//
//   // Modern color scheme
//   final Color primaryColor = const Color(0xFF00695C); // Teal
//   final Color accentColor = const Color(0xFFFFA000); // Amber
//   final Color backgroundColor = const Color(0xFFF5F5F5); // Light beige
//   final Color cardColor = Colors.white;
//   final Color secondaryTextColor = const Color(0xFF757575); // Grey
//
//   // Tabs content
//   List<Widget> get _screens => [
//     _buildHomeTab(),
//     SavedPropertiesScreen(),
//     const PostPropertyScreen(),
//     const ProfileScreen(),
//   ];
//
//   void _onTabTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: backgroundColor,
//       body: AnimatedSwitcher(
//         duration: const Duration(milliseconds: 300),
//         child: _screens[_selectedIndex],
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _selectedIndex,
//         onTap: _onTabTapped,
//         selectedItemColor: accentColor,
//         unselectedItemColor: primaryColor.withOpacity(0.6),
//         backgroundColor: cardColor,
//         type: BottomNavigationBarType.fixed,
//         selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
//         unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
//         elevation: 8,
//         items: [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home, size: 28),
//             label: 'Home',
//             activeIcon: Icon(Icons.home_filled, size: 28, color: accentColor),
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.favorite_border, size: 28),
//             label: 'Saved',
//             activeIcon: Icon(Icons.favorite, size: 28, color: accentColor),
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.post_add, size: 28),
//             label: 'Post',
//             activeIcon: Icon(Icons.post_add, size: 28, color: accentColor),
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person_outline, size: 28),
//             label: 'Profile',
//             activeIcon: Icon(Icons.person, size: 28, color: accentColor),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildHomeTab() {
//     return Scaffold(
//       backgroundColor: backgroundColor,
//       appBar: AppBar(
//         backgroundColor: cardColor,
//         elevation: 0,
//         title: Text(
//           'Discover Hyderabad Homes',
//           style: TextStyle(
//             color: primaryColor,
//             fontWeight: FontWeight.bold,
//             fontSize: 20,
//             letterSpacing: 0.5,
//           ),
//         ),
//         centerTitle: false,
//         leading: Padding(
//           padding: const EdgeInsets.only(left: 16),
//           child: CircleAvatar(
//             backgroundColor: accentColor.withOpacity(0.1),
//             child: Icon(Icons.person, color: primaryColor, size: 24),
//           ),
//         ),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.notifications_none, color: primaryColor, size: 26),
//             onPressed: () {},
//           ),
//           const SizedBox(width: 8),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//         child: SingleChildScrollView(
//           physics: const BouncingScrollPhysics(),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               _buildSearchBar(),
//               const SizedBox(height: 24),
//               _buildCategories(),
//               const SizedBox(height: 24),
//               GestureDetector(
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => FeaturedPropertiesScreen(
//                         primaryColor: primaryColor,
//                         accentColor: accentColor,
//                         backgroundColor: backgroundColor,
//                         cardColor: cardColor,
//                       ),
//                     ),
//                   );
//                 },
//                 child: _buildSectionHeader('Featured Properties'),
//               ),
//               const SizedBox(height: 12),
//               _buildFeaturedList(),
//               const SizedBox(height: 24),
//               GestureDetector(
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => NearbyPropertiesScreen(
//                         primaryColor: primaryColor,
//                         accentColor: accentColor,
//                         backgroundColor: backgroundColor,
//                         cardColor: cardColor,
//                       ),
//                     ),
//                   );
//                 },
//                 child: _buildSectionHeader('Nearby Properties'),
//               ),
//               const SizedBox(height: 12),
//               _buildNearbyList(),
//               const SizedBox(height: 16),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildSearchBar() {
//     return Container(
//       decoration: BoxDecoration(
//         color: cardColor,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: primaryColor.withOpacity(0.05),
//             blurRadius: 8,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: TextField(
//         decoration: InputDecoration(
//           hintText: 'Search Hyderabad neighborhoods or keywords',
//           hintStyle: TextStyle(color: secondaryTextColor, fontSize: 16),
//           prefixIcon: Icon(Icons.search, color: primaryColor, size: 24),
//           filled: true,
//           fillColor: Colors.transparent,
//           contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12),
//             borderSide: BorderSide.none,
//           ),
//           enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12),
//             borderSide: BorderSide.none,
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12),
//             borderSide: BorderSide(color: accentColor, width: 1.5),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildCategories() {
//     final categories = ['House', 'Apartment', 'Villa', 'Land', 'Office'];
//     return SizedBox(
//       height: 40,
//       child: ListView.separated(
//         scrollDirection: Axis.horizontal,
//         physics: const BouncingScrollPhysics(),
//         itemCount: categories.length,
//         separatorBuilder: (_, __) => const SizedBox(width: 12),
//         itemBuilder: (context, index) {
//           return GestureDetector(
//             onTap: () {},
//             child: Chip(
//               label: Text(
//                 categories[index],
//                 style: TextStyle(
//                   color: primaryColor,
//                   fontWeight: FontWeight.w600,
//                   fontSize: 14,
//                 ),
//               ),
//               backgroundColor: accentColor.withOpacity(0.15),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//               elevation: 2,
//             ),
//           );
//         },
//       ),
//     );
//   }
//
//   Widget _buildSectionHeader(String title) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           title,
//           style: TextStyle(
//             fontSize: 22,
//             fontWeight: FontWeight.bold,
//             color: primaryColor,
//             letterSpacing: 0.3,
//           ),
//         ),
//         Icon(Icons.arrow_forward_ios, size: 18, color: accentColor),
//       ],
//     );
//   }
//
//   Widget _buildFeaturedList() {
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
//     ];
//
//     return SizedBox(
//       height: 220,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         physics: const BouncingScrollPhysics(),
//         itemCount: featuredProperties.length,
//         itemBuilder: (context, index) {
//           final property = featuredProperties[index];
//           return PropertyCard(
//             title: property['title']!,
//             price: property['price']!,
//             location: property['location']!,
//             isHorizontal: true,
//             primaryColor: primaryColor,
//             accentColor: accentColor,
//             cardColor: cardColor,
//             secondaryTextColor: secondaryTextColor,
//           );
//         },
//       ),
//     );
//   }
//
//   Widget _buildNearbyList() {
//     final nearbyProperties = [
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
//     ];
//
//     return Column(
//       children: List.generate(nearbyProperties.length, (index) {
//         final property = nearbyProperties[index];
//         return Padding(
//           padding: const EdgeInsets.only(bottom: 12),
//           child: PropertyCard(
//             title: property['title']!,
//             price: property['price']!,
//             location: property['location']!,
//             isHorizontal: false,
//             primaryColor: primaryColor,
//             accentColor: accentColor,
//             cardColor: cardColor,
//             secondaryTextColor: secondaryTextColor,
//           ),
//         );
//       }),
//     );
//   }
// }
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
//
//   const PropertyCard({
//     Key? key,
//     required this.title,
//     required this.price,
//     required this.location,
//     required this.isHorizontal,
//     required this.primaryColor,
//     required this.accentColor,
//     required this.cardColor,
//     required this.secondaryTextColor,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: isHorizontal ? 220 : double.infinity,
//       margin: EdgeInsets.only(right: isHorizontal ? 12 : 0),
//       decoration: BoxDecoration(
//         color: cardColor,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: primaryColor.withOpacity(0.08),
//             blurRadius: 10,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           ClipRRect(
//             borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
//             child: Container(
//               height: isHorizontal ? 100 : 140,
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 color: accentColor.withOpacity(0.2),
//                 borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
//               ),
//               child: Center(
//                 child: Icon(Icons.home, color: accentColor.withOpacity(0.4), size: 40),
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(12),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   title,
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                     color: primaryColor,
//                     letterSpacing: 0.2,
//                   ),
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   location,
//                   style: TextStyle(
//                     color: secondaryTextColor,
//                     fontSize: 14,
//                     letterSpacing: 0.2,
//                   ),
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//                 const SizedBox(height: 8),
//                 Text(
//                   price,
//                   style: TextStyle(
//                     fontWeight: FontWeight.w700,
//                     color: accentColor,
//                     fontSize: 16,
//                     letterSpacing: 0.3,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class FeaturedPropertiesScreen extends StatelessWidget {
//   final Color primaryColor;
//   final Color accentColor;
//   final Color backgroundColor;
//   final Color cardColor;
//
//   const FeaturedPropertiesScreen({
//     Key? key,
//     required this.primaryColor,
//     required this.accentColor,
//     required this.backgroundColor,
//     required this.cardColor,
//   }) : super(key: key);
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
//     return Scaffold(
//       backgroundColor: backgroundColor,
//       appBar: AppBar(
//         backgroundColor: cardColor,
//         elevation: 0,
//         title: Text(
//           'Featured Properties',
//           style: TextStyle(
//             color: primaryColor,
//             fontWeight: FontWeight.bold,
//             fontSize: 20,
//             letterSpacing: 0.5,
//           ),
//         ),
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: primaryColor, size: 26),
//           onPressed: () => Navigator.pop(context),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//         child: ListView.builder(
//           physics: const BouncingScrollPhysics(),
//           itemCount: featuredProperties.length,
//           itemBuilder: (context, index) {
//             final property = featuredProperties[index];
//             return Padding(
//               padding: const EdgeInsets.only(bottom: 12),
//               child: PropertyCard(
//                 title: property['title']!,
//                 price: property['price']!,
//                 location: property['location']!,
//                 isHorizontal: false,
//                 primaryColor: primaryColor,
//                 accentColor: accentColor,
//                 cardColor: cardColor,
//                 secondaryTextColor: const Color(0xFF757575),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
//
// class NearbyPropertiesScreen extends StatelessWidget {
//   final Color primaryColor;
//   final Color accentColor;
//   final Color backgroundColor;
//   final Color cardColor;
//
//   const NearbyPropertiesScreen({
//     Key? key,
//     required this.primaryColor,
//     required this.accentColor,
//     required this.backgroundColor,
//     required this.cardColor,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final nearbyProperties = [
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
//       {
//         'title': 'Cozy Apartment in Secunderabad',
//         'price': '₹60,000 / month',
//         'location': 'Secunderabad, Hyderabad',
//       },
//       {
//         'title': 'Premium Villa in Shamshabad',
//         'price': '₹1,40,000 / month',
//         'location': 'Shamshabad, Hyderabad',
//       },
//       {
//         'title': 'Residential Plot in Miyapur',
//         'price': '₹45,000 / month',
//         'location': 'Miyapur, Hyderabad',
//       },
//       {
//         'title': 'Luxury Flat in Somajiguda',
//         'price': '₹90,000 / month',
//         'location': 'Somajiguda, Hyderabad',
//       },
//       {
//         'title': 'Modern House in Sainikpuri',
//         'price': '₹75,000 / month',
//         'location': 'Sainikpuri, Hyderabad',
//       },
//     ];
//
//     return Scaffold(
//       backgroundColor: backgroundColor,
//       appBar: AppBar(
//         backgroundColor: cardColor,
//         elevation: 0,
//         title: Text(
//           'Nearby Properties',
//           style: TextStyle(
//             color: primaryColor,
//             fontWeight: FontWeight.bold,
//             fontSize: 20,
//             letterSpacing: 0.5,
//           ),
//         ),
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: primaryColor, size: 26),
//           onPressed: () => Navigator.pop(context),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//         child: ListView.builder(
//           physics: const BouncingScrollPhysics(),
//           itemCount: nearbyProperties.length,
//           itemBuilder: (context, index) {
//             final property = nearbyProperties[index];
//             return Padding(
//               padding: const EdgeInsets.only(bottom: 12),
//               child: PropertyCard(
//                 title: property['title']!,
//                 price: property['price']!,
//                 location: property['location']!,
//                 isHorizontal: false,
//                 primaryColor: primaryColor,
//                 accentColor: accentColor,
//                 cardColor: cardColor,
//                 secondaryTextColor: const Color(0xFF757575),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }



// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_state_manager/src/simple/get_state.dart';
// import 'package:madhanvasu_app/Feature-based/profile/profile_page.dart';
// import 'package:madhanvasu_app/app/configuration/%20themes/app_colors.dart';
// import 'package:madhanvasu_app/madhanvasu_lib/ui_screens/saved_propertys.dart';
//
// import '../../Feature-based/bottam_nav/bottam_navbar_screen.dart';
// import '../../Feature-based/profile/profile_controller/profile_controller.dart';
//
//
// class RealEstateHomeScreen extends StatefulWidget {
//   const RealEstateHomeScreen({Key? key}) : super(key: key);
//
//   @override
//   State<RealEstateHomeScreen> createState() => _RealEstateHomeScreenState();
// }
//
// class _RealEstateHomeScreenState extends State<RealEstateHomeScreen> {
//   int _selectedIndex = 0;
//
//   // Color scheme matching SavedPropertiesScreen
//   final Color primaryColor = Colors.black;
//   final Color accentColor = const Color(0xFFFFEB3B);
//   final Color backgroundColor = const Color(0xFFFFFDE7);
//   final Color cardColor = Colors.white;
//   final Color secondaryTextColor = const Color(0xFF757575);
//
//
//   @override
//   void initState() {
//     super.initState();
//     if (!Get.isRegistered<ProfileController>()) {
//       Get.put(ProfileController());
//     }
//   }
//
//
//   // Tabs content
//   List<Widget> get _screens => [
//     _buildHomeTab(),
//     SavedPropertiesScreen(),
//     // PostPropertyScreen(
//     //   onPostSubmitted: (propertyDetails) {
//     //     Navigator.push(
//     //       context,
//     //       MaterialPageRoute(
//     //         builder: (context) => PropertyPreviewScreen(
//     //           propertyDetails: propertyDetails,
//     //           primaryColor: primaryColor,
//     //           accentColor: accentColor,
//     //           backgroundColor: backgroundColor,
//     //           cardColor: cardColor,
//     //           secondaryTextColor: secondaryTextColor,
//     //         ),
//     //       ),
//     //     );
//     //   },
//     // ),
//
//     // const PostPropertyScreen(),
//
//     GetBuilder<ProfileController>(
//       init: ProfileController(),
//       builder: (_) => const ProfileScreen(),
//     ),
//
//   ];
//
//   void _onTabTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: backgroundColor,
//       body: AnimatedSwitcher(
//         duration: const Duration(milliseconds: 300),
//         child: _screens[_selectedIndex],
//       ),
//       // bottomNavigationBar: BottomNavigationBar(
//       //   currentIndex: _selectedIndex,
//       //   onTap: _onTabTapped,
//       //   selectedItemColor: accentColor,
//       //   unselectedItemColor: primaryColor.withOpacity(0.6),
//       //   backgroundColor: cardColor,
//       //   type: BottomNavigationBarType.fixed,
//       //   selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
//       //   unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
//       //   elevation: 8,
//       //   items: [
//       //     BottomNavigationBarItem(
//       //       icon: Icon(Icons.home, size: 28),
//       //       label: 'Home',
//       //       activeIcon: Icon(Icons.home_filled, size: 28, color: accentColor),
//       //     ),
//       //     BottomNavigationBarItem(
//       //       icon: Icon(Icons.favorite_border, size: 28),
//       //       label: 'Saved',
//       //       activeIcon: Icon(Icons.favorite, size: 28, color: accentColor),
//       //     ),
//       //     BottomNavigationBarItem(
//       //       icon: Icon(Icons.post_add, size: 28),
//       //       label: 'Post',
//       //       activeIcon: Icon(Icons.post_add, size: 28, color: accentColor),
//       //     ),
//       //     BottomNavigationBarItem(
//       //       icon: Icon(Icons.person_outline, size: 28),
//       //       label: 'Profile',
//       //       activeIcon: Icon(Icons.person, size: 28, color: accentColor),
//       //     ),
//       //   ],
//       // ),
//
//       bottomNavigationBar: CustomBottomNavigationBar(
//         currentIndex: _selectedIndex,
//         // toggleTheme: _toggleTheme,
//         toggleTheme: () {  }, primaryColor: AppColors.primary, bottomNavbarColor: AppColors.secondary, cardColor: AppColors.backgroundColor,  // Pass callback here
//       ),
//     );
//   }
//
//   Widget _buildHomeTab() {
//     return Scaffold(
//       backgroundColor: backgroundColor,
//       appBar: AppBar(
//         backgroundColor: cardColor,
//         elevation: 1,
//         title: Text(
//           'Discover Hyderabad Homes',
//           style: TextStyle(
//             color: Colors.teal,
//             fontWeight: FontWeight.bold,
//             fontSize: 20,
//             letterSpacing: 0.5,
//           ),
//         ),
//         centerTitle: false,
//         leading: Padding(
//           padding: const EdgeInsets.only(left: 16),
//           child: CircleAvatar(
//             backgroundColor: accentColor.withOpacity(0.1),
//             child: Icon(Icons.person, color: primaryColor, size: 24),
//           ),
//         ),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.notifications_none, color: primaryColor, size: 26),
//             onPressed: () {},
//           ),
//           const SizedBox(width: 8),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//         child: SingleChildScrollView(
//           physics: const BouncingScrollPhysics(),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               _buildSearchBar(),
//               const SizedBox(height: 24),
//               _buildCategories(),
//               const SizedBox(height: 24),
//               GestureDetector(
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => FeaturedPropertiesScreen(
//                         primaryColor: Colors.orange,
//                         accentColor: Colors.deepOrangeAccent,
//                         backgroundColor: Colors.white,
//                         cardColor: Colors.white,
//                         secondaryTextColor: Colors.grey,
//                         // bottomNavbar: Colors.orangeAccent,
//                       )
//
//                     ),
//                   );
//                 },
//                 child: _buildSectionHeader('Featured Properties'),
//               ),
//               const SizedBox(height: 12),
//               _buildFeaturedList(),
//               const SizedBox(height: 24),
//               GestureDetector(
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => NearbyPropertiesScreen(
//                         primaryColor: primaryColor,
//                         accentColor: accentColor,
//                         backgroundColor: backgroundColor,
//                         cardColor: cardColor,
//                       ),
//                     ),
//                   );
//                 },
//                 child: _buildSectionHeader('Nearby Properties'),
//               ),
//               const SizedBox(height: 12),
//               _buildNearbyList(),
//               const SizedBox(height: 16),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildSearchBar() {
//     return Container(
//       decoration: BoxDecoration(
//         color: cardColor,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: primaryColor.withOpacity(0.05),
//             blurRadius: 8,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: TextField(
//         decoration: InputDecoration(
//           hintText: 'Search Hyderabad neighborhoods or keywords',
//           hintStyle: TextStyle(color: secondaryTextColor, fontSize: 16),
//           prefixIcon: Icon(Icons.search, color: primaryColor, size: 24),
//           filled: true,
//           fillColor: Colors.transparent,
//           contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12),
//             borderSide: BorderSide.none,
//           ),
//           enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12),
//             borderSide: BorderSide.none,
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12),
//             borderSide: BorderSide(color: accentColor, width: 1.5),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildCategories() {
//     final categories = ['House', 'Apartment', 'Villa', 'Land', 'Office'];
//     return SizedBox(
//       height: 40,
//       child: ListView.separated(
//         scrollDirection: Axis.horizontal,
//         physics: const BouncingScrollPhysics(),
//         itemCount: categories.length,
//         separatorBuilder: (_, __) => const SizedBox(width: 12),
//         itemBuilder: (context, index) {
//           return GestureDetector(
//             onTap: () {},
//             child: Chip(
//               label: Text(
//                 categories[index],
//                 style: TextStyle(
//                   color: primaryColor,
//                   fontWeight: FontWeight.w600,
//                   fontSize: 14,
//                 ),
//               ),
//               backgroundColor: accentColor.withOpacity(0.15),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//               elevation: 2,
//             ),
//           );
//         },
//       ),
//     );
//   }
//
//   Widget _buildSectionHeader(String title) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           title,
//           style: TextStyle(
//             fontSize: 22,
//             fontWeight: FontWeight.bold,
//             color: primaryColor,
//             letterSpacing: 0.3,
//           ),
//         ),
//         Icon(Icons.arrow_forward_ios, size: 18, color: accentColor),
//       ],
//     );
//   }
//
//   Widget _buildFeaturedList() {
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
//     ];
//
//     return SizedBox(
//       height: 220,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         physics: const BouncingScrollPhysics(),
//         itemCount: featuredProperties.length,
//         itemBuilder: (context, index) {
//           final property = featuredProperties[index];
//           return PropertyCard(
//             title: property['title']!,
//             price: property['price']!,
//             location: property['location']!,
//             isHorizontal: true,
//             primaryColor: primaryColor,
//             accentColor: accentColor,
//             cardColor: cardColor,
//             secondaryTextColor: secondaryTextColor,
//           );
//         },
//       ),
//     );
//   }
//
//   Widget _buildNearbyList() {
//     final nearbyProperties = [
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
//     ];
//
//     return Column(
//       children: List.generate(nearbyProperties.length, (index) {
//         final property = nearbyProperties[index];
//         return Padding(
//             padding: const EdgeInsets.only(bottom: 12),
//             child: PropertyCard(
//               title: property['title']!,
//               price: property['price']!,
//               location: property['location']!,
//               isHorizontal: false,
//               primaryColor: primaryColor,
//               accentColor: accentColor,
//               cardColor: cardColor,
//               secondaryTextColor: secondaryTextColor,
//             ),
//         );
//       }),
//     );
//   }
// }
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
//
//   const PropertyCard({
//     Key? key,
//     required this.title,
//     required this.price,
//     required this.location,
//     required this.isHorizontal,
//     required this.primaryColor,
//     required this.accentColor,
//     required this.cardColor,
//     required this.secondaryTextColor,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: isHorizontal ? 220 : double.infinity,
//       margin: EdgeInsets.only(right: isHorizontal ? 12 : 0),
//       decoration: BoxDecoration(
//         color: cardColor,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: primaryColor.withOpacity(0.08),
//             blurRadius: 10,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           ClipRRect(
//             borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
//             child: Container(
//               height: isHorizontal ? 100 : 140,
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 color: accentColor.withOpacity(0.2),
//                 borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
//               ),
//               child: Center(
//                 child: Icon(Icons.home, color: accentColor.withOpacity(0.4), size: 40),
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(12),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   title,
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                     color: primaryColor,
//                     letterSpacing: 0.2,
//                   ),
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   location,
//                   style: TextStyle(
//                     color: secondaryTextColor,
//                     fontSize: 14,
//                     letterSpacing: 0.2,
//                   ),
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//                 const SizedBox(height: 8),
//                 Text(
//                   price,
//                   style: TextStyle(
//                     fontWeight: FontWeight.w700,
//                     color: accentColor,
//                     fontSize: 16,
//                     letterSpacing: 0.3,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class FeaturedPropertiesScreen extends StatelessWidget {
//   final Color primaryColor;
//   final Color accentColor;
//   final Color backgroundColor;
//   final Color cardColor;
//
//   const FeaturedPropertiesScreen({
//     Key? key,
//     required this.primaryColor,
//     required this.accentColor,
//     required this.backgroundColor,
//     required this.cardColor, required Color secondaryTextColor, required Color bottomNavbar,
//   }) : super(key: key);
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
//     return Scaffold(
//       backgroundColor: backgroundColor,
//       appBar: AppBar(
//         backgroundColor: cardColor,
//         elevation: 1,
//         title: Text(
//           'Featured Properties',
//           style: TextStyle(
//             color: primaryColor,
//             fontWeight: FontWeight.bold,
//             fontSize: 20,
//             letterSpacing: 0.5,
//           ),
//         ),
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: primaryColor, size: 26),
//           onPressed: () => Navigator.pop(context),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//         child: ListView.builder(
//           physics: const BouncingScrollPhysics(),
//           itemCount: featuredProperties.length,
//           itemBuilder: (context, index) {
//             final property = featuredProperties[index];
//             var secondaryTextColor;
//             return Padding(
//               padding: const EdgeInsets.only(bottom: 12),
//               child: PropertyCard(
//                 title: property['title']!,
//                 price: property['price']!,
//                 location: property['location']!,
//                 isHorizontal: false,
//                 primaryColor: primaryColor,
//                 accentColor: accentColor,
//                 cardColor: cardColor,
//                 secondaryTextColor: secondaryTextColor,
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
//
// class NearbyPropertiesScreen extends StatelessWidget {
//   final Color primaryColor;
//   final Color accentColor;
//   final Color backgroundColor;
//   final Color cardColor;
//
//   const NearbyPropertiesScreen({
//     Key? key,
//     required this.primaryColor,
//     required this.accentColor,
//     required this.backgroundColor,
//     required this.cardColor,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final nearbyProperties = [
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
//       {
//         'title': 'Cozy Apartment in Secunderabad',
//         'price': '₹60,000 / month',
//         'location': 'Secunderabad, Hyderabad',
//       },
//       {
//         'title': 'Premium Villa in Shamshabad',
//         'price': '₹1,40,000 / month',
//         'location': 'Shamshabad, Hyderabad',
//       },
//       {
//         'title': 'Residential Plot in Miyapur',
//         'price': '₹45,000 / month',
//         'location': 'Miyapur, Hyderabad',
//       },
//       {
//         'title': 'Luxury Flat in Somajiguda',
//         'price': '₹90,000 / month',
//         'location': 'Somajiguda, Hyderabad',
//       },
//       {
//         'title': 'Modern House in Sainikpuri',
//         'price': '₹75,000 / month',
//         'location': 'Sainikpuri, Hyderabad',
//       },
//     ];
//
//     return Scaffold(
//       backgroundColor: backgroundColor,
//       appBar: AppBar(
//         backgroundColor: cardColor,
//         elevation: 1,
//         title: Text(
//           'Nearby Properties',
//           style: TextStyle(
//             color: primaryColor,
//             fontWeight: FontWeight.bold,
//             fontSize: 20,
//             letterSpacing: 0.5,
//           ),
//         ),
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: primaryColor, size: 26),
//           onPressed: () => Navigator.pop(context),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//         child: ListView.builder(
//           physics: const BouncingScrollPhysics(),
//           itemCount: nearbyProperties.length,
//           itemBuilder: (context, index) {
//             final property = nearbyProperties[index];
//             var secondaryTextColor;
//             return Padding(
//               padding: const EdgeInsets.only(bottom: 12),
//               child: PropertyCard(
//                 title: property['title']!,
//                 price: property['price']!,
//                 location: property['location']!,
//                 isHorizontal: false,
//                 primaryColor: primaryColor,
//                 accentColor: accentColor,
//                 cardColor: cardColor,
//                 secondaryTextColor: secondaryTextColor,
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }