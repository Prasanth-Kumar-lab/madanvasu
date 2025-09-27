// import 'package:flutter/material.dart';
// import 'package:madhanvasu_app/madhanvasu_lib/ui_screens/ui2_screens/saved_propertys_ui2.dart';
// import '../../../Feature-based/profile/profile_page.dart';
// // import 'package:real_estate/ui_screens/post_propertys.dart';
// // import 'package:real_estate/ui_screens/profile_page.dart';
// // import 'package:real_estate/ui_screens/saved_propertys.dart';
// // import 'package:real_estate/ui_screens/ui2_screens/saved_propertys_ui2.dart';
//
// class RealEstateHomeScreen_ui2 extends StatefulWidget {
//   const RealEstateHomeScreen_ui2({Key? key}) : super(key: key);
//
//   @override
//   State<RealEstateHomeScreen_ui2> createState() => _RealEstateHomeScreen_ui2State();
// }
//
// class _RealEstateHomeScreen_ui2State extends State<RealEstateHomeScreen_ui2> {
//   int _selectedIndex = 0;
//
//   // Color scheme
//   final Color primaryColor = Colors.black;
//   final Color accentColor = const Color(0xFFFFEB3B);
//   final Color backgroundColor = const Color(0xFFFFFDE7);
//   final Color cardColor = Colors.white;
//   final Color secondaryTextColor = const Color(0xFF757575);
//
//   // Tabs content
//   List<Widget> get _screens => [
//     _buildHomeTab(),
//     SavedPropertiesScreen_ui2(),
//     // const PostPropertyScreen(onPostSubmitted: (propertyDetails) {
//     //
//     // },),
//      ProfileScreen(),
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
//            // const SizedBox(width: 8),
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
//                         primaryColor: primaryColor,
//                         accentColor: accentColor,
//                         backgroundColor: backgroundColor,
//                         cardColor: cardColor,
//                         secondaryTextColor: secondaryTextColor,
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
//                         secondaryTextColor: secondaryTextColor,
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
//         'contactName': 'John Doe',
//         'contactNumber': '+91 98765 43210',
//       },
//       {
//         'title': 'Modern Apartment in Gachibowli',
//         'price': '₹80,000 / month',
//         'location': 'Gachibowli, Hyderabad',
//         'contactName': 'Jane Smith',
//         'contactNumber': '+91 87654 32109',
//       },
//       {
//         'title': 'Spacious Plot in Madhapur',
//         'price': '₹40,000 / month',
//         'location': 'Madhapur, Hyderabad',
//         'contactName': 'Alice Brown',
//         'contactNumber': '+91 76543 21098',
//       },
//       {
//         'title': 'Premium Flat in Hitech City',
//         'price': '₹95,000 / month',
//         'location': 'Hitech City, Hyderabad',
//         'contactName': 'Bob Wilson',
//         'contactNumber': '+91 65432 10987',
//       },
//       {
//         'title': 'Cozy House in Jubilee Hills',
//         'price': '₹1,20,000 / month',
//         'location': 'Jubilee Hills, Hyderabad',
//         'contactName': 'Emma Davis',
//         'contactNumber': '+91 54321 09876',
//       },
//     ];
//
//     return SizedBox(
//       height: 160,
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
//             contactName: property['contactName']!,
//             contactNumber: property['contactNumber']!,
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
//         'contactName': 'Michael Lee',
//         'contactNumber': '+91 43210 98765',
//       },
//       {
//         'title': 'Luxury Villa in Manikonda',
//         'price': '₹1,80,000 / month',
//         'location': 'Manikonda, Hyderabad',
//         'contactName': 'Sarah Taylor',
//         'contactNumber': '+91 32109 87654',
//       },
//       {
//         'title': 'Commercial Plot in Kukatpally',
//         'price': '₹50,000 / month',
//         'location': 'Kukatpally, Hyderabad',
//         'contactName': 'David Clark',
//         'contactNumber': '+91 21098 76543',
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
//             contactName: property['contactName']!,
//             contactNumber: property['contactNumber']!,
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
//   final String contactName;
//   final String contactNumber;
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
//     required this.contactName,
//     required this.contactNumber,
//     required this.isHorizontal,
//     required this.primaryColor,
//     required this.accentColor,
//     required this.cardColor,
//     required this.secondaryTextColor,
//   }) : super(key: key);
//
//   void _showContactDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           backgroundColor: cardColor,
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//           title: Text(
//             'Contact Details',
//             style: TextStyle(
//               color: primaryColor,
//               fontWeight: FontWeight.bold,
//               fontSize: 20,
//             ),
//           ),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 // 'Name: $contactName',
//                 'Name: Balu',
//                 style: TextStyle(
//                   color: secondaryTextColor,
//                   fontSize: 16,
//                 ),
//               ),
//               const SizedBox(height: 8),
//               Text(
//                 'Number: $contactNumber',
//                 style: TextStyle(
//                   color: secondaryTextColor,
//                   fontSize: 16,
//                 ),
//               ),
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: Text(
//                 'Close',
//                 style: TextStyle(
//                   color: accentColor,
//                   fontWeight: FontWeight.w600,
//                   fontSize: 16,
//                 ),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
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
//       child: Padding(
//         padding: const EdgeInsets.all(12),
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
//             const SizedBox(height: 4),
//             Text(
//               location,
//               style: TextStyle(
//                 color: secondaryTextColor,
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
//             const SizedBox(height: 8),
//             Align(
//               alignment: Alignment.centerRight,
//               child: TextButton(
//                 onPressed: () => _showContactDialog(context),
//                 style: TextButton.styleFrom(
//                   backgroundColor: accentColor.withOpacity(0.2),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                 ),
//                 child: Text(
//                   'Contact',
//                   style: TextStyle(
//                     color: primaryColor,
//                     fontWeight: FontWeight.w600,
//                     fontSize: 14,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
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
//   final Color secondaryTextColor;
//
//   const FeaturedPropertiesScreen({
//     Key? key,
//     required this.primaryColor,
//     required this.accentColor,
//     required this.backgroundColor,
//     required this.cardColor,
//     required this.secondaryTextColor,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final featuredProperties = [
//       {
//         'title': 'Luxury Villa in Banjara Hills',
//         'price': '₹1,50,000 / month',
//         'location': 'Banjara Hills, Hyderabad',
//         'contactName': 'John Doe',
//         'contactNumber': '+91 98765 43210',
//       },
//       {
//         'title': 'Modern Apartment in Gachibowli',
//         'price': '₹80,000 / month',
//         'location': 'Gachibowli, Hyderabad',
//         'contactName': 'Jane Smith',
//         'contactNumber': '+91 87654 32109',
//       },
//       {
//         'title': 'Spacious Plot in Madhapur',
//         'price': '₹40,000 / month',
//         'location': 'Madhapur, Hyderabad',
//         'contactName': 'Alice Brown',
//         'contactNumber': '+91 76543 21098',
//       },
//       {
//         'title': 'Premium Flat in Hitech City',
//         'price': '₹95,000 / month',
//         'location': 'Hitech City, Hyderabad',
//         'contactName': 'Bob Wilson',
//         'contactNumber': '+91 65432 10987',
//       },
//       {
//         'title': 'Cozy House in Jubilee Hills',
//         'price': '₹1,20,000 / month',
//         'location': 'Jubilee Hills, Hyderabad',
//         'contactName': 'Emma Davis',
//         'contactNumber': '+91 54321 09876',
//       },
//       {
//         'title': 'Elegant Apartment in Kondapur',
//         'price': '₹70,000 / month',
//         'location': 'Kondapur, Hyderabad',
//         'contactName': 'Michael Lee',
//         'contactNumber': '+91 43210 98765',
//       },
//       {
//         'title': 'Luxury Villa in Manikonda',
//         'price': '₹1,80,000 / month',
//         'location': 'Manikonda, Hyderabad',
//         'contactName': 'Sarah Taylor',
//         'contactNumber': '+91 32109 87654',
//       },
//       {
//         'title': 'Commercial Plot in Kukatpally',
//         'price': '₹50,000 / month',
//         'location': 'Kukatpally, Hyderabad',
//         'contactName': 'David Clark',
//         'contactNumber': '+91 21098 76543',
//       },
//       {
//         'title': 'Modern Flat in Begumpet',
//         'price': '₹85,000 / month',
//         'location': 'Begumpet, Hyderabad',
//         'contactName': 'Laura Adams',
//         'contactNumber': '+91 10987 65432',
//       },
//       {
//         'title': 'Spacious House in Uppal',
//         'price': '₹65,000 / month',
//         'location': 'Uppal, Hyderabad',
//         'contactName': 'James White',
//         'contactNumber': '+91 09876 54321',
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
//             color: Colors.teal,
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
//                 contactName: property['contactName']!,
//                 contactNumber: property['contactNumber']!,
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
//   final Color secondaryTextColor;
//
//   const NearbyPropertiesScreen({
//     Key? key,
//     required this.primaryColor,
//     required this.accentColor,
//     required this.backgroundColor,
//     required this.cardColor,
//     required this.secondaryTextColor,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final nearbyProperties = [
//       {
//         'title': 'Elegant Apartment in Kondapur',
//         'price': '₹70,000 / month',
//         'location': 'Kondapur, Hyderabad',
//         'contactName': 'Michael Lee',
//         'contactNumber': '+91 43210 98765',
//       },
//       {
//         'title': 'Luxury Villa in Manikonda',
//         'price': '₹1,80,000 / month',
//         'location': 'Manikonda, Hyderabad',
//         'contactName': 'Sarah Taylor',
//         'contactNumber': '+91 32109 87654',
//       },
//       {
//         'title': 'Commercial Plot in Kukatpally',
//         'price': '₹50,000 / month',
//         'location': 'Kukatpally, Hyderabad',
//         'contactName': 'David Clark',
//         'contactNumber': '+91 21098 76543',
//       },
//       {
//         'title': 'Modern Flat in Begumpet',
//         'price': '₹85,000 / month',
//         'location': 'Begumpet, Hyderabad',
//         'contactName': 'Laura Adams',
//         'contactNumber': '+91 10987 65432',
//       },
//       {
//         'title': 'Spacious House in Uppal',
//         'price': '₹65,000 / month',
//         'location': 'Uppal, Hyderabad',
//         'contactName': 'James White',
//         'contactNumber': '+91 09876 54321',
//       },
//       {
//         'title': 'Cozy Apartment in Secunderabad',
//         'price': '₹60,000 / month',
//         'location': 'Secunderabad, Hyderabad',
//         'contactName': 'Olivia Green',
//         'contactNumber': '+91 98765 43211',
//       },
//       {
//         'title': 'Premium Villa in Shamshabad',
//         'price': '₹1,40,000 / month',
//         'location': 'Shamshabad, Hyderabad',
//         'contactName': 'William Harris',
//         'contactNumber': '+91 87654 32110',
//       },
//       {
//         'title': 'Residential Plot in Miyapur',
//         'price': '₹45,000 / month',
//         'location': 'Miyapur, Hyderabad',
//         'contactName': 'Sophia Martinez',
//         'contactNumber': '+91 76543 21099',
//       },
//       {
//         'title': 'Luxury Flat in Somajiguda',
//         'price': '₹90,000 / month',
//         'location': 'Somajiguda, Hyderabad',
//         'contactName': 'Daniel Thompson',
//         'contactNumber': '+91 65432 10988',
//       },
//       {
//         'title': 'Modern House in Sainikpuri',
//         'price': '₹75,000 / month',
//         'location': 'Sainikpuri, Hyderabad',
//         'contactName': 'Isabella Anderson',
//         'contactNumber': '+91 54321 09877',
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
//             color: Colors.teal,
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
//                 contactName: property['contactName']!,
//                 contactNumber: property['contactNumber']!,
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
//
//
//
//
//
//
//
//
//
// ////////////////////////////////////////////////////////
//
// //
// // import 'package:flutter/material.dart';
// // import 'package:real_estate/ui_screens/post_propertys.dart';
// // import 'package:real_estate/ui_screens/profile_page.dart';
// // import 'package:real_estate/ui_screens/saved_propertys.dart';
// // import 'package:real_estate/ui_screens/ui2_screens/saved_propertys_ui2.dart';
// //
// // class RealEstateHomeScreen_ui2 extends StatefulWidget {
// //   const RealEstateHomeScreen_ui2({Key? key}) : super(key: key);
// //
// //   @override
// //   State<RealEstateHomeScreen_ui2> createState() => _RealEstateHomeScreen_ui2State();
// // }
// //
// // class _RealEstateHomeScreen_ui2State extends State<RealEstateHomeScreen_ui2> {
// //   int _selectedIndex = 0;
// //
// //   // Original color scheme
// //   final Color primaryColor = Colors.black;
// //   final Color accentColor = const Color(0xFFFFEB3B);
// //   final Color backgroundColor = const Color(0xFFFFFDE7);
// //   final Color cardColor = Colors.white;
// //   final Color secondaryTextColor = const Color(0xFF757575);
// //
// //   List<Widget> get _screens => [
// //     _buildHomeTab(),
// //     SavedPropertiesScreen_ui2(),
// //     PostPropertyScreen(
// //       onPostSubmitted: (propertyDetails) {
// //         Navigator.push(
// //           context,
// //           MaterialPageRoute(
// //             builder: (context) => PropertyPreviewScreen(
// //               propertyDetails: propertyDetails,
// //               primaryColor: primaryColor,
// //               accentColor: accentColor,
// //               backgroundColor: backgroundColor,
// //               cardColor: cardColor,
// //               secondaryTextColor: secondaryTextColor,
// //             ),
// //           ),
// //         );
// //       },
// //     ),
// //     const ProfileScreen(),
// //   ];
// //
// //   void _onTabTapped(int index) {
// //     setState(() {
// //       _selectedIndex = index;
// //     });
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: backgroundColor,
// //       body: AnimatedSwitcher(
// //         duration: const Duration(milliseconds: 300),
// //         transitionBuilder: (child, animation) => FadeTransition(
// //           opacity: animation,
// //           child: child,
// //         ),
// //         child: _screens[_selectedIndex],
// //       ),
// //       bottomNavigationBar: Container(
// //         decoration: BoxDecoration(
// //           boxShadow: [
// //             BoxShadow(
// //               color: primaryColor.withOpacity(0.1),
// //               blurRadius: 8,
// //               offset: const Offset(0, -2),
// //             ),
// //           ],
// //         ),
// //         child: BottomNavigationBar(
// //           currentIndex: _selectedIndex,
// //           onTap: _onTabTapped,
// //           selectedItemColor: accentColor,
// //           unselectedItemColor: primaryColor.withOpacity(0.6),
// //           backgroundColor: cardColor,
// //           type: BottomNavigationBarType.fixed,
// //           selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
// //           unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
// //           elevation: 0,
// //           items: [
// //             BottomNavigationBarItem(
// //               icon: Icon(Icons.home_outlined, size: 28),
// //               label: 'Home',
// //               activeIcon: Icon(Icons.home, size: 28, color: accentColor),
// //             ),
// //             BottomNavigationBarItem(
// //               icon: Icon(Icons.favorite_border, size: 28),
// //               label: 'Saved',
// //               activeIcon: Icon(Icons.favorite, size: 28, color: accentColor),
// //             ),
// //             BottomNavigationBarItem(
// //               icon: Icon(Icons.add_circle_outline, size: 28),
// //               label: 'Post',
// //               activeIcon: Icon(Icons.add_circle, size: 28, color: accentColor),
// //             ),
// //             BottomNavigationBarItem(
// //               icon: Icon(Icons.person_outline, size: 28),
// //               label: 'Profile',
// //               activeIcon: Icon(Icons.person, size: 28, color: accentColor),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// //
// //   Widget _buildHomeTab() {
// //     return Scaffold(
// //       backgroundColor: backgroundColor,
// //       appBar: AppBar(
// //         backgroundColor: cardColor,
// //         elevation: 1,
// //         title: Text(
// //           'Discover Hyderabad Homes',
// //           style: TextStyle(
// //             color: Colors.teal,
// //             fontWeight: FontWeight.bold,
// //             fontSize: 20,
// //             letterSpacing: 0.5,
// //           ),
// //         ),
// //         centerTitle: false,
// //         leading: Padding(
// //           padding: const EdgeInsets.only(left: 16),
// //           child: CircleAvatar(
// //             backgroundColor: accentColor.withOpacity(0.1),
// //             child: Icon(Icons.person, color: primaryColor, size: 24),
// //           ),
// //         ),
// //         actions: [
// //           IconButton(
// //             icon: Icon(Icons.notifications_none, color: primaryColor, size: 26),
// //             onPressed: () {},
// //           ),
// //           const SizedBox(width: 8),
// //         ],
// //       ),
// //       body: Padding(
// //         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
// //         child: SingleChildScrollView(
// //           physics: const BouncingScrollPhysics(),
// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [
// //               _buildSearchBar(),
// //               const SizedBox(height: 24),
// //               _buildCategories(),
// //               const SizedBox(height: 24),
// //               GestureDetector(
// //                 onTap: () {
// //                   Navigator.push(
// //                     context,
// //                     MaterialPageRoute(
// //                       builder: (context) => FeaturedPropertiesScreen(
// //                         primaryColor: primaryColor,
// //                         accentColor: accentColor,
// //                         backgroundColor: backgroundColor,
// //                         cardColor: cardColor,
// //                         secondaryTextColor: secondaryTextColor,
// //                       ),
// //                     ),
// //                   );
// //                 },
// //                 child: _buildSectionHeader('Featured Properties'),
// //               ),
// //               const SizedBox(height: 12),
// //               _buildFeaturedList(),
// //               const SizedBox(height: 24),
// //               GestureDetector(
// //                 onTap: () {
// //                   Navigator.push(
// //                     context,
// //                     MaterialPageRoute(
// //                       builder: (context) => NearbyPropertiesScreen(
// //                         primaryColor: primaryColor,
// //                         accentColor: accentColor,
// //                         backgroundColor: backgroundColor,
// //                         cardColor: cardColor,
// //                         secondaryTextColor: secondaryTextColor,
// //                       ),
// //                     ),
// //                   );
// //                 },
// //                 child: _buildSectionHeader('Nearby Properties'),
// //               ),
// //               const SizedBox(height: 12),
// //               _buildNearbyList(),
// //               const SizedBox(height: 16),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// //
// //   Widget _buildSearchBar() {
// //     return Container(
// //       decoration: BoxDecoration(
// //         color: cardColor,
// //         borderRadius: BorderRadius.circular(12),
// //         boxShadow: [
// //           BoxShadow(
// //             color: primaryColor.withOpacity(0.05),
// //             blurRadius: 8,
// //             offset: const Offset(0, 2),
// //           ),
// //         ],
// //       ),
// //       child: TextField(
// //         decoration: InputDecoration(
// //           hintText: 'Search Hyderabad neighborhoods or keywords',
// //           hintStyle: TextStyle(color: secondaryTextColor, fontSize: 16),
// //           prefixIcon: Icon(Icons.search, color: primaryColor, size: 24),
// //           suffixIcon: Icon(Icons.filter_list, color: primaryColor, size: 24),
// //           filled: true,
// //           fillColor: Colors.transparent,
// //           contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
// //           border: OutlineInputBorder(
// //             borderRadius: BorderRadius.circular(12),
// //             borderSide: BorderSide.none,
// //           ),
// //           enabledBorder: OutlineInputBorder(
// //             borderRadius: BorderRadius.circular(12),
// //             borderSide: BorderSide.none,
// //           ),
// //           focusedBorder: OutlineInputBorder(
// //             borderRadius: BorderRadius.circular(12),
// //             borderSide: BorderSide(color: accentColor, width: 1.5),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// //
// //   Widget _buildCategories() {
// //     final categories = ['House', 'Apartment', 'Villa', 'Land', 'Office'];
// //     return SizedBox(
// //       height: 40,
// //       child: ListView.separated(
// //         scrollDirection: Axis.horizontal,
// //         physics: const BouncingScrollPhysics(),
// //         itemCount: categories.length,
// //         separatorBuilder: (_, __) => const SizedBox(width: 12),
// //         itemBuilder: (context, index) {
// //           return GestureDetector(
// //             onTap: () {},
// //             child: Chip(
// //               label: Text(
// //                 categories[index],
// //                 style: TextStyle(
// //                   color: primaryColor,
// //                   fontWeight: FontWeight.w600,
// //                   fontSize: 14,
// //                 ),
// //               ),
// //               backgroundColor: accentColor.withOpacity(0.15),
// //               shape: RoundedRectangleBorder(
// //                 borderRadius: BorderRadius.circular(20),
// //                 side: BorderSide(color: accentColor.withOpacity(0.3)),
// //               ),
// //               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
// //               elevation: 2,
// //             ),
// //           );
// //         },
// //       ),
// //     );
// //   }
// //
// //   Widget _buildSectionHeader(String title) {
// //     return Row(
// //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //       children: [
// //         Text(
// //           title,
// //           style: TextStyle(
// //             fontSize: 22,
// //             fontWeight: FontWeight.bold,
// //             color: primaryColor,
// //             letterSpacing: 0.3,
// //           ),
// //         ),
// //         Icon(Icons.arrow_forward_ios, size: 18, color: accentColor),
// //       ],
// //     );
// //   }
// //
// //   Widget _buildFeaturedList() {
// //     final featuredProperties = [
// //       {
// //         'title': 'Luxury Villa in Banjara Hills',
// //         'price': '₹1,50,000 / month',
// //         'location': 'Banjara Hills, Hyderabad',
// //         'contactName': 'John Doe',
// //         'contactNumber': '+91 98765 43210',
// //       },
// //       {
// //         'title': 'Modern Apartment in Gachibowli',
// //         'price': '₹80,000 / month',
// //         'location': 'Gachibowli, Hyderabad',
// //         'contactName': 'Jane Smith',
// //         'contactNumber': '+91 87654 32109',
// //       },
// //       {
// //         'title': 'Spacious Plot in Madhapur',
// //         'price': '₹40,000 / month',
// //         'location': 'Madhapur, Hyderabad',
// //         'contactName': 'Alice Brown',
// //         'contactNumber': '+91 76543 21098',
// //       },
// //     ];
// //
// //     return SizedBox(
// //       height: 140,
// //       child: ListView.builder(
// //         scrollDirection: Axis.horizontal,
// //         physics: const BouncingScrollPhysics(),
// //         itemCount: featuredProperties.length,
// //         itemBuilder: (context, index) {
// //           final property = featuredProperties[index];
// //           return PropertyCard(
// //             title: property['title']!,
// //             price: property['price']!,
// //             location: property['location']!,
// //             contactName: property['contactName']!,
// //             contactNumber: property['contactNumber']!,
// //             isHorizontal: true,
// //             primaryColor: primaryColor,
// //             accentColor: accentColor,
// //             cardColor: cardColor,
// //             secondaryTextColor: secondaryTextColor,
// //           );
// //         },
// //       ),
// //     );
// //   }
// //
// //   Widget _buildNearbyList() {
// //     final nearbyProperties = [
// //       {
// //         'title': 'Elegant Apartment in Kondapur',
// //         'price': '₹70,000 / month',
// //         'location': 'Kondapur, Hyderabad',
// //         'contactName': 'Michael Lee',
// //         'contactNumber': '+91 43210 98765',
// //       },
// //       {
// //         'title': 'Luxury Villa in Manikonda',
// //         'price': '₹1,80,000 / month',
// //         'location': 'Manikonda, Hyderabad',
// //         'contactName': 'Sarah Taylor',
// //         'contactNumber': '+91 32109 87654',
// //       },
// //     ];
// //
// //     return Column(
// //       children: List.generate(nearbyProperties.length, (index) {
// //         final property = nearbyProperties[index];
// //         return Padding(
// //           padding: const EdgeInsets.only(bottom: 12),
// //           child: PropertyCard(
// //             title: property['title']!,
// //             price: property['price']!,
// //             location: property['location']!,
// //             contactName: property['contactName']!,
// //             contactNumber: property['contactNumber']!,
// //             isHorizontal: false,
// //             primaryColor: primaryColor,
// //             accentColor: accentColor,
// //             cardColor: cardColor,
// //             secondaryTextColor: secondaryTextColor,
// //           ),
// //         );
// //       }),
// //     );
// //   }
// // }
// //
// // class PropertyCard extends StatelessWidget {
// //   final String title;
// //   final String price;
// //   final String location;
// //   final String contactName;
// //   final String contactNumber;
// //   final bool isHorizontal;
// //   final Color primaryColor;
// //   final Color accentColor;
// //   final Color cardColor;
// //   final Color secondaryTextColor;
// //
// //   const PropertyCard({
// //     Key? key,
// //     required this.title,
// //     required this.price,
// //     required this.location,
// //     required this.contactName,
// //     required this.contactNumber,
// //     required this.isHorizontal,
// //     required this.primaryColor,
// //     required this.accentColor,
// //     required this.cardColor,
// //     required this.secondaryTextColor,
// //   }) : super(key: key);
// //
// //   void _showContactDialog(BuildContext context) {
// //     showDialog(
// //       context: context,
// //       builder: (BuildContext context) {
// //         return AlertDialog(
// //           backgroundColor: cardColor,
// //           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
// //           title: Text(
// //             'Contact Details',
// //             style: TextStyle(
// //               color: primaryColor,
// //               fontWeight: FontWeight.bold,
// //               fontSize: 20,
// //             ),
// //           ),
// //           content: Column(
// //             mainAxisSize: MainAxisSize.min,
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [
// //               Text(
// //                 'Name: $contactName',
// //                 style: TextStyle(
// //                   color: secondaryTextColor,
// //                   fontSize: 16,
// //                 ),
// //               ),
// //               const SizedBox(height: 8),
// //               Text(
// //                 'Number: $contactNumber',
// //                 style: TextStyle(
// //                   color: secondaryTextColor,
// //                   fontSize: 16,
// //                 ),
// //               ),
// //             ],
// //           ),
// //           actions: [
// //             TextButton(
// //               onPressed: () => Navigator.pop(context),
// //               child: Text(
// //                 'Close',
// //                 style: TextStyle(
// //                   color: accentColor,
// //                   fontWeight: FontWeight.w600,
// //                   fontSize: 16,
// //                 ),
// //               ),
// //             ),
// //           ],
// //         );
// //       },
// //     );
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Container(
// //       width: isHorizontal ? 220 : double.infinity,
// //       margin: EdgeInsets.only(right: isHorizontal ? 12 : 0),
// //       decoration: BoxDecoration(
// //         color: cardColor,
// //         borderRadius: BorderRadius.circular(16),
// //         boxShadow: [
// //           BoxShadow(
// //             color: primaryColor.withOpacity(0.08),
// //             blurRadius: 10,
// //             offset: const Offset(0, 4),
// //           ),
// //         ],
// //       ),
// //       child: Padding(
// //         padding: const EdgeInsets.all(12),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             Text(
// //               title,
// //               style: TextStyle(
// //                 fontSize: 16,
// //                 fontWeight: FontWeight.bold,
// //                 color: primaryColor,
// //                 letterSpacing: 0.2,
// //               ),
// //               maxLines: 1,
// //               overflow: TextOverflow.ellipsis,
// //             ),
// //             const SizedBox(height: 4),
// //             Text(
// //               location,
// //               style: TextStyle(
// //                 color: secondaryTextColor,
// //                 fontSize: 14,
// //                 letterSpacing: 0.2,
// //               ),
// //               maxLines: 1,
// //               overflow: TextOverflow.ellipsis,
// //             ),
// //             const SizedBox(height: 8),
// //             Text(
// //               price,
// //               style: TextStyle(
// //                 fontWeight: FontWeight.w700,
// //                 color: accentColor,
// //                 fontSize: 16,
// //                 letterSpacing: 0.3,
// //               ),
// //             ),
// //             const SizedBox(height: 8),
// //             Align(
// //               alignment: Alignment.centerRight,
// //               child: TextButton(
// //                 onPressed: () => _showContactDialog(context),
// //                 style: TextButton.styleFrom(
// //                   backgroundColor: accentColor.withOpacity(0.2),
// //                   shape: RoundedRectangleBorder(
// //                     borderRadius: BorderRadius.circular(8),
// //                   ),
// //                 ),
// //                 child: Text(
// //                   'Contact',
// //                   style: TextStyle(
// //                     color: primaryColor,
// //                     fontWeight: FontWeight.w600,
// //                     fontSize: 14,
// //                   ),
// //                 ),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
// //
// // class PropertyPreviewScreen extends StatefulWidget {
// //   final Map<String, String> propertyDetails;
// //   final Color primaryColor;
// //   final Color accentColor;
// //   final Color backgroundColor;
// //   final Color cardColor;
// //   final Color secondaryTextColor;
// //
// //   const PropertyPreviewScreen({
// //     Key? key,
// //     required this.propertyDetails,
// //     required this.primaryColor,
// //     required this.accentColor,
// //     required this.backgroundColor,
// //     required this.cardColor,
// //     required this.secondaryTextColor,
// //   }) : super(key: key);
// //
// //   @override
// //   State<PropertyPreviewScreen> createState() => _PropertyPreviewScreenState();
// // }
// //
// // class _PropertyPreviewScreenState extends State<PropertyPreviewScreen> {
// //   late Map<String, String> _editableDetails;
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     _editableDetails = Map.from(widget.propertyDetails);
// //   }
// //
// //   void _editField(String key, String currentValue) {
// //     TextEditingController controller = TextEditingController(text: currentValue);
// //     showDialog(
// //       context: context,
// //       builder: (context) => AlertDialog(
// //         backgroundColor: widget.cardColor,
// //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
// //         title: Text(
// //           'Edit ${key.replaceFirst(key[0], key[0].toUpperCase())}',
// //           style: TextStyle(
// //             color: widget.primaryColor,
// //             fontWeight: FontWeight.bold,
// //             fontSize: 20,
// //           ),
// //         ),
// //         content: TextField(
// //           controller: controller,
// //           decoration: InputDecoration(
// //             border: OutlineInputBorder(
// //               borderRadius: BorderRadius.circular(12),
// //               borderSide: BorderSide.none,
// //             ),
// //             filled: true,
// //             fillColor: widget.accentColor.withOpacity(0.1),
// //           ),
// //         ),
// //         actions: [
// //           TextButton(
// //             onPressed: () => Navigator.pop(context),
// //             child: Text(
// //               'Cancel',
// //               style: TextStyle(color: widget.secondaryTextColor),
// //             ),
// //           ),
// //           TextButton(
// //             onPressed: () {
// //               setState(() {
// //                 _editableDetails[key] = controller.text;
// //               });
// //               Navigator.pop(context);
// //             },
// //             child: Text(
// //               'Save',
// //               style: TextStyle(color: widget.accentColor),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: widget.backgroundColor,
// //       appBar: AppBar(
// //         backgroundColor: widget.cardColor,
// //         elevation: 1,
// //         title: Text(
// //           'Property Preview',
// //           style: TextStyle(
// //             color: Colors.teal,
// //             fontWeight: FontWeight.bold,
// //             fontSize: 20,
// //             letterSpacing: 0.5,
// //           ),
// //         ),
// //         leading: IconButton(
// //           icon: Icon(Icons.arrow_back, color: widget.primaryColor),
// //           onPressed: () => Navigator.pop(context),
// //         ),
// //       ),
// //       body: Padding(
// //         padding: const EdgeInsets.all(16),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             ..._editableDetails.entries.map((entry) => Padding(
// //               padding: const EdgeInsets.only(bottom: 16),
// //               child: Row(
// //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                 children: [
// //                   Expanded(
// //                     child: Column(
// //                       crossAxisAlignment: CrossAxisAlignment.start,
// //                       children: [
// //                         Text(
// //                           entry.key.replaceFirst(entry.key[0], entry.key[0].toUpperCase()),
// //                           style: TextStyle(
// //                             color: widget.secondaryTextColor,
// //                             fontSize: 14,
// //                           ),
// //                         ),
// //                         const SizedBox(height: 4),
// //                         Text(
// //                           entry.value,
// //                           style: TextStyle(
// //                             color: widget.primaryColor,
// //                             fontSize: 16,
// //                             fontWeight: FontWeight.w600,
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                   ),
// //                   IconButton(
// //                     icon: Icon(Icons.edit, color: widget.accentColor, size: 20),
// //                     onPressed: () => _editField(entry.key, entry.value),
// //                   ),
// //                 ],
// //               ),
// //             )),
// //             const Spacer(),
// //             Row(
// //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //               children: [
// //                 Expanded(
// //                   child: ElevatedButton(
// //                     onPressed: () => Navigator.pop(context),
// //                     style: ElevatedButton.styleFrom(
// //                       backgroundColor: widget.cardColor,
// //                       foregroundColor: widget.primaryColor,
// //                       shape: RoundedRectangleBorder(
// //                         borderRadius: BorderRadius.circular(12),
// //                         side: BorderSide(color: widget.primaryColor.withOpacity(0.2)),
// //                       ),
// //                       padding: const EdgeInsets.symmetric(vertical: 16),
// //                     ),
// //                     child: const Text(
// //                       'Cancel',
// //                       style: TextStyle(
// //                         fontWeight: FontWeight.w600,
// //                         fontSize: 16,
// //                       ),
// //                     ),
// //                   ),
// //                 ),
// //                 const SizedBox(width: 12),
// //                 Expanded(
// //                   child: ElevatedButton(
// //                     onPressed: () {
// //                       Navigator.push(
// //                         context,
// //                         MaterialPageRoute(
// //                           builder: (context) => PaymentScreen(
// //                             propertyDetails: _editableDetails,
// //                             primaryColor: widget.primaryColor,
// //                             accentColor: widget.accentColor,
// //                             backgroundColor: widget.backgroundColor,
// //                             cardColor: widget.cardColor,
// //                             secondaryTextColor: widget.secondaryTextColor,
// //                           ),
// //                         ),
// //                       );
// //                     },
// //                     style: ElevatedButton.styleFrom(
// //                       backgroundColor: widget.accentColor,
// //                       foregroundColor: widget.cardColor,
// //                       shape: RoundedRectangleBorder(
// //                         borderRadius: BorderRadius.circular(12),
// //                       ),
// //                       padding: const EdgeInsets.symmetric(vertical: 16),
// //                     ),
// //                     child: const Text(
// //                       'Confirm',
// //                       style: TextStyle(
// //                         fontWeight: FontWeight.w600,
// //                         fontSize: 16,
// //                       ),
// //                     ),
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
// //
// // class PaymentScreen extends StatelessWidget {
// //   final Map<String, String> propertyDetails;
// //   final Color primaryColor;
// //   final Color accentColor;
// //   final Color backgroundColor;
// //   final Color cardColor;
// //   final Color secondaryTextColor;
// //
// //   const PaymentScreen({
// //     Key? key,
// //     required this.propertyDetails,
// //     required this.primaryColor,
// //     required this.accentColor,
// //     required this.backgroundColor,
// //     required this.cardColor,
// //     required this.secondaryTextColor,
// //   }) : super(key: key);
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: backgroundColor,
// //       appBar: AppBar(
// //         backgroundColor: cardColor,
// //         elevation: 1,
// //         title: Text(
// //           'Payment',
// //           style: TextStyle(
// //             color: Colors.teal,
// //             fontWeight: FontWeight.bold,
// //             fontSize: 20,
// //             letterSpacing: 0.5,
// //           ),
// //         ),
// //         leading: IconButton(
// //           icon: Icon(Icons.arrow_back, color: primaryColor),
// //           onPressed: () => Navigator.pop(context),
// //         ),
// //       ),
// //       body: Padding(
// //         padding: const EdgeInsets.all(16),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             Text(
// //               'Payment Details',
// //               style: TextStyle(
// //                 color: primaryColor,
// //                 fontSize: 20,
// //                 fontWeight: FontWeight.bold,
// //               ),
// //             ),
// //             const SizedBox(height: 16),
// //             Container(
// //               padding: const EdgeInsets.all(16),
// //               decoration: BoxDecoration(
// //                 color: cardColor,
// //                 borderRadius: BorderRadius.circular(16),
// //                 boxShadow: [
// //                   BoxShadow(
// //                     color: primaryColor.withOpacity(0.08),
// //                     blurRadius: 10,
// //                     offset: const Offset(0, 4),
// //                   ),
// //                 ],
// //               ),
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   Text(
// //                     'Property: ${propertyDetails['title']}',
// //                     style: TextStyle(
// //                       color: primaryColor,
// //                       fontSize: 16,
// //                       fontWeight: FontWeight.w600,
// //                     ),
// //                   ),
// //                   const SizedBox(height: 8),
// //                   Text(
// //                     'Listing Fee: ₹5000',
// //                     style: TextStyle(
// //                       color: secondaryTextColor,
// //                       fontSize: 14,
// //                     ),
// //                   ),
// //                   const SizedBox(height: 8),
// //                   Text(
// //                     'Tax: ₹900',
// //                     style: TextStyle(
// //                       color: secondaryTextColor,
// //                       fontSize: 14,
// //                     ),
// //                   ),
// //                   const Divider(height: 24),
// //                   Text(
// //                     'Total: ₹5900',
// //                     style: TextStyle(
// //                       color: accentColor,
// //                       fontSize: 18,
// //                       fontWeight: FontWeight.w700,
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //             const SizedBox(height: 24),
// //             TextField(
// //               decoration: InputDecoration(
// //                 labelText: 'Card Number',
// //                 labelStyle: TextStyle(color: secondaryTextColor),
// //                 border: OutlineInputBorder(
// //                   borderRadius: BorderRadius.circular(12),
// //                   borderSide: BorderSide.none,
// //                 ),
// //                 filled: true,
// //                 fillColor: cardColor,
// //               ),
// //             ),
// //             const SizedBox(height: 16),
// //             Row(
// //               children: [
// //                 Expanded(
// //                   child: TextField(
// //                     decoration: InputDecoration(
// //                       labelText: 'Expiry Date',
// //                       labelStyle: TextStyle(color: secondaryTextColor),
// //                       border: OutlineInputBorder(
// //                         borderRadius: BorderRadius.circular(12),
// //                         borderSide: BorderSide.none,
// //                       ),
// //                       filled: true,
// //                       fillColor: cardColor,
// //                     ),
// //                   ),
// //                 ),
// //                 const SizedBox(width: 12),
// //                 Expanded(
// //                   child: TextField(
// //                     decoration: InputDecoration(
// //                       labelText: 'CVV',
// //                       labelStyle: TextStyle(color: secondaryTextColor),
// //                       border: OutlineInputBorder(
// //                         borderRadius: BorderRadius.circular(12),
// //                         borderSide: BorderSide.none,
// //                       ),
// //                       filled: true,
// //                       fillColor: cardColor,
// //                     ),
// //                   ),
// //                 ),
// //               ],
// //             ),
// //             const Spacer(),
// //             ElevatedButton(
// //               onPressed: () {
// //                 ScaffoldMessenger.of(context).showSnackBar(
// //                   SnackBar(
// //                     content: Text(
// //                       'Payment Successful! Property Listed.',
// //                       style: TextStyle(color: cardColor),
// //                     ),
// //                     backgroundColor: accentColor,
// //                     duration: const Duration(seconds: 3),
// //                   ),
// //                 );
// //                 Navigator.popUntil(context, (route) => route.isFirst);
// //               },
// //               style: ElevatedButton.styleFrom(
// //                 backgroundColor: accentColor,
// //                 foregroundColor: cardColor,
// //                 shape: RoundedRectangleBorder(
// //                   borderRadius: BorderRadius.circular(12),
// //                 ),
// //                 padding: const EdgeInsets.symmetric(vertical: 16),
// //                 minimumSize: const Size(double.infinity, 50),
// //               ),
// //               child: const Text(
// //                 'Pay Now',
// //                 style: TextStyle(
// //                   fontWeight: FontWeight.w600,
// //                   fontSize: 16,
// //                 ),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
// //
// // class FeaturedPropertiesScreen extends StatelessWidget {
// //   final Color primaryColor;
// //   final Color accentColor;
// //   final Color backgroundColor;
// //   final Color cardColor;
// //   final Color secondaryTextColor;
// //
// //   const FeaturedPropertiesScreen({
// //     Key? key,
// //     required this.primaryColor,
// //     required this.accentColor,
// //     required this.backgroundColor,
// //     required this.cardColor,
// //     required this.secondaryTextColor,
// //   }) : super(key: key);
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     final featuredProperties = [
// //       {
// //         'title': 'Luxury Villa in Banjara Hills',
// //         'price': '₹1,50,000 / month',
// //         'location': 'Banjara Hills, Hyderabad',
// //         'contactName': 'John Doe',
// //         'contactNumber': '+91 98765 43210',
// //       },
// //       {
// //         'title': 'Modern Apartment in Gachibowli',
// //         'price': '₹80,000 / month',
// //         'location': 'Gachibowli, Hyderabad',
// //         'contactName': 'Jane Smith',
// //         'contactNumber': '+91 87654 32109',
// //       },
// //       {
// //         'title': 'Spacious Plot in Madhapur',
// //         'price': '₹40,000 / month',
// //         'location': 'Madhapur, Hyderabad',
// //         'contactName': 'Alice Brown',
// //         'contactNumber': '+91 76543 21098',
// //       },
// //     ];
// //
// //     return Scaffold(
// //       backgroundColor: backgroundColor,
// //       appBar: AppBar(
// //         backgroundColor: cardColor,
// //         elevation: 1,
// //         title: Text(
// //           'Featured Properties',
// //           style: TextStyle(
// //             color: Colors.teal,
// //             fontWeight: FontWeight.bold,
// //             fontSize: 20,
// //             letterSpacing: 0.5,
// //           ),
// //         ),
// //         leading: IconButton(
// //           icon: Icon(Icons.arrow_back, color: primaryColor, size: 26),
// //           onPressed: () => Navigator.pop(context),
// //         ),
// //       ),
// //       body: Padding(
// //         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
// //         child: ListView.builder(
// //           physics: const BouncingScrollPhysics(),
// //           itemCount: featuredProperties.length,
// //           itemBuilder: (context, index) {
// //             final property = featuredProperties[index];
// //             return Padding(
// //               padding: const EdgeInsets.only(bottom: 12),
// //               child: PropertyCard(
// //                 title: property['title']!,
// //                 price: property['price']!,
// //                 location: property['location']!,
// //                 contactName: property['contactName']!,
// //                 contactNumber: property['contactNumber']!,
// //                 isHorizontal: false,
// //                 primaryColor: primaryColor,
// //                 accentColor: accentColor,
// //                 cardColor: cardColor,
// //                 secondaryTextColor: secondaryTextColor,
// //               ),
// //             );
// //           },
// //         ),
// //       ),
// //     );
// //   }
// // }
// //
// // class NearbyPropertiesScreen extends StatelessWidget {
// //   final Color primaryColor;
// //   final Color accentColor;
// //   final Color backgroundColor;
// //   final Color cardColor;
// //   final Color secondaryTextColor;
// //
// //   const NearbyPropertiesScreen({
// //     Key? key,
// //     required this.primaryColor,
// //     required this.accentColor,
// //     required this.backgroundColor,
// //     required this.cardColor,
// //     required this.secondaryTextColor,
// //   }) : super(key: key);
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     final nearbyProperties = [
// //       {
// //         'title': 'Elegant Apartment in Kondapur',
// //         'price': '₹70,000 / month',
// //         'location': 'Kondapur, Hyderabad',
// //         'contactName': 'Michael Lee',
// //         'contactNumber': '+91 43210 98765',
// //       },
// //       {
// //         'title': 'Luxury Villa in Manikonda',
// //         'price': '₹1,80,000 / month',
// //         'location': 'Manikonda, Hyderabad',
// //         'contactName': 'Sarah Taylor',
// //         'contactNumber': '+91 32109 87654',
// //       },
// //     ];
// //
// //     return Scaffold(
// //       backgroundColor: backgroundColor,
// //       appBar: AppBar(
// //         backgroundColor: cardColor,
// //         elevation: 1,
// //         title: Text(
// //           'Nearby Properties',
// //           style: TextStyle(
// //             color: Colors.teal,
// //             fontWeight: FontWeight.bold,
// //             fontSize: 20,
// //             letterSpacing: 0.5,
// //           ),
// //         ),
// //         leading: IconButton(
// //           icon: Icon(Icons.arrow_back, color: primaryColor, size: 26),
// //           onPressed: () => Navigator.pop(context),
// //         ),
// //       ),
// //       body: Padding(
// //         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
// //         child: ListView.builder(
// //           physics: const BouncingScrollPhysics(),
// //           itemCount: nearbyProperties.length,
// //           itemBuilder: (context, index) {
// //             final property = nearbyProperties[index];
// //             return Padding(
// //               padding: const EdgeInsets.only(bottom: 12),
// //               child: PropertyCard(
// //                 title: property['title']!,
// //                 price: property['price']!,
// //                 location: property['location']!,
// //                 contactName: property['contactName']!,
// //                 contactNumber: property['contactNumber']!,
// //                 isHorizontal: false,
// //                 primaryColor: primaryColor,
// //                 accentColor: accentColor,
// //                 cardColor: cardColor,
// //                 secondaryTextColor: secondaryTextColor,
// //               ),
// //             );
// //           },
// //         ),
// //       ),
// //     );
// //   }
// // }