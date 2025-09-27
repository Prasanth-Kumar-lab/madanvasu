// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:madhanvasu_app/app/configuration/%20themes/app_colors.dart';
//
// import '../../app/utils/shared_pref_helper.dart';
// import '../app_Language/app_language_screen.dart';
// import '../auth/login_view/loginScreen.dart';
//
//
// class ProfileScreen extends StatelessWidget {
//   final Color primaryColor = const Color(0xFF2E2E2E);
//   final Color accentColor = const Color(0xFFe57c42);
//   final Color backgroundColor = const Color(0xFFF5F5F5);
//   final Color cardColor = Colors.white;
//
//   const ProfileScreen({super.key});
//
//   // Helper function to fetch all user data
//   Future<Map<String, String>> _fetchUserData() async {
//     final Map<String, String> userData = {};
//     for (var key in SharedPrefHelper.userKeys) {
//       final value = await SharedPrefHelper.getUserData(key);
//       userData[key] = value ?? '';
//     }
//     return userData;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<Map<String, String>>(
//       future: _fetchUserData(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Scaffold(
//             backgroundColor:AppColors. backgroundColor,
//             body: const Center(child: CircularProgressIndicator()),
//           );
//         }
//         if (snapshot.hasError) {
//           return Scaffold(
//             backgroundColor: backgroundColor,
//             body: Center(child: Text('Error loading profile: ${snapshot.error}')),
//           );
//         }
//
//         final userData = snapshot.data ?? {};
//         final String name = userData['personName'] ?? 'Guest';
//         final String email = userData['email'] ?? 'No email available';
//         final String phone = userData['mobileNumber'] ?? 'No phone number available';
//
//         return Scaffold(
//           backgroundColor: Color(0xFFFFFDE7),
//           appBar: AppBar(
//             automaticallyImplyLeading: false,
//             title: Text(
//               'Profile'.tr,
//               style: GoogleFonts.poppins(
//                 color: Colors.black,
//                 fontSize: 22,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//             backgroundColor: AppColors.secondary.withOpacity(0.8),
//             elevation: 2,
//             centerTitle: true,
//             iconTheme: IconThemeData(color: Color(0xFFe57c42)),
//           ),
//           body: SingleChildScrollView(
//             padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 // Profile picture with gradient border
//                 Stack(
//                   alignment: Alignment.bottomRight,
//                   children: [
//                     Container(
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         gradient: LinearGradient(
//                           colors: [Color(0xFFe4b201),Color(0xFFe4b201) .withOpacity(0.6)],
//                           begin: Alignment.topLeft,
//                           end: Alignment.bottomRight,
//                         ),
//                         boxShadow: [
//                           BoxShadow(
//                             color: primaryColor.withOpacity(0.2),
//                             blurRadius: 8,
//                             offset: const Offset(0, 4),
//                           ),
//                         ],
//                       ),
//                       padding: const EdgeInsets.all(4),
//                       child: CircleAvatar(
//                         radius: 56,
//                         // backgroundImage: userData['profile_image']?.isNotEmpty ?? false
//                         //     ? NetworkImage(userData['profile_image']!)
//                         //     : const AssetImage('assets/profile.jpg') as ImageProvider,
//                         backgroundColor: cardColor,
//                       ),
//                     ),
//                     GestureDetector(
//                       onTap: () {
//                         //Edit profile picture logic
//                       },
//                       child: CircleAvatar(
//                         radius: 18,
//                         backgroundColor: Color(0xFFe57c42),
//                         child: Icon(Icons.edit, size: 20, color: Colors.white),
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 20),
//
//                 // Name
//                 Text(
//                   name,
//                   style: GoogleFonts.poppins(
//                     fontSize: 26,
//                     fontWeight: FontWeight.w700,
//                     color: primaryColor,
//                   ),
//                 ),
//                 const SizedBox(height: 6),
//
//                 // Email
//                 Text(
//                   email,
//                   style: GoogleFonts.poppins(
//                     fontSize: 16,
//                     color: primaryColor.withOpacity(0.7),
//                   ),
//                 ),
//                 const SizedBox(height: 6),
//
//                 // Phone
//                 Text(
//                   phone,
//                   style: GoogleFonts.poppins(
//                     fontSize: 16,
//                     color: primaryColor.withOpacity(0.7),
//                   ),
//                 ),
//                 const SizedBox(height: 32),
//
//                 // Buttons with animation
//                 _buildOptionTile(
//                   icon: Icons.edit,
//                   label: 'get_started'.tr,
//                   onTap: () {
//                     // Navigate to edit profile screen
//                   },
//                 ),
//                 _buildOptionTile(
//                   icon: Icons.list_alt,
//                   label: 'My Listings',
//                   onTap: () {
//                     // Navigator.push(
//                     //   context,
//                     //   MaterialPageRoute(builder: (_) => const MyListingsScreen()),
//                     // );   ////////  Balu
//                   },
//                 ),
//                 _buildOptionTile(
//                   icon: Icons.privacy_tip
//                   ,
//                   label: 'Privacy & Policy',
//                   onTap: () {
//                     // Navigate to settings screen
//                   },
//                 ),
//                 _buildOptionTile(
//                   icon: Icons.logout,
//                   label: 'Logout',
//                   onTap: () {
//                     //LogOut logic here
//                     SharedPrefHelper.clearUserData();
//                     Navigator.pushReplacement(
//                       context,
//                       MaterialPageRoute(
//                         builder: (_) => Login_Screen(toggleTheme: () {}),
//                       ),
//                     );
//                   },
//                   //color: const Color(0xFFE53935), // Red for logout
//                 ), ///LanguageSelectionScreen
//                 ///
//
//                 _buildOptionTile(
//                   icon: Icons.privacy_tip
//                   ,
//                   label: 'LanguageSelectionScreen',
//                   onTap: () {
//                     Navigator.push(context, MaterialPageRoute(builder: (_)=> LanguageSelectionScreen()));
//                   },
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   Widget _buildOptionTile({
//     required IconData icon,
//     required String label,
//     required VoidCallback onTap,
//     Color? color,
//   }) {
//     return GestureDetector(
//       onTap: onTap,
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 200),
//         margin: const EdgeInsets.symmetric(vertical: 10),
//         decoration: BoxDecoration(
//           color: cardColor,
//           border: Border.all(color: Color(0xFFe4b201), width: 1.5),
//           borderRadius: BorderRadius.circular(16),
//           boxShadow: [
//             BoxShadow(
//               color:Color(0xFFe57c42).withOpacity(0.1),
//               blurRadius: 10,
//               offset: const Offset(0, 4),
//             ),
//           ],
//         ),
//         child: ListTile(
//           contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//           leading: CircleAvatar(
//             radius: 24,
//             backgroundColor: Color(0xFFe57c42),
//             child: Icon(icon, color: color ?? Colors.white, size: 26),
//           ),
//           title: Text(
//             label,
//             style: GoogleFonts.poppins(
//               color: color ?? primaryColor,
//               fontSize: 16,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//           trailing: Icon(
//             Icons.arrow_forward_ios,
//             size: 18,
//             color: Color(0xFFe57c42),
//           ),
//         ),
//       ),
//     );
//   }
// }

///////////


// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:madhanvasu_app/Feature-based/profile/profile_controller/profile_controller.dart';
// import '../../../app/configuration/ themes/app_colors.dart';
// import '../app_Language/app_language_screen.dart';
// import '../bottam_nav/bottam_navbar_screen.dart';
//
//
// class ProfileScreen extends GetView<ProfileController> {
//   const ProfileScreen({super.key});
//
//   Color get primaryColor => const Color(0xFF2E2E2E);
//   Color get accentColor => const Color(0xFFe57c42);
//   Color get backgroundColor => const Color(0xFFF5F5F5);
//   Color get cardColor => Colors.white;
//   final  int _selectedIndex = 3;
//
//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       if (controller.isLoading.value) {
//         return Scaffold(
//           backgroundColor: AppColors.backgroundColor,
//           body: const Center(child: CircularProgressIndicator()),
//         );
//       }
//
//       return Scaffold(
//         backgroundColor: const Color(0xFFFFFDE7),
//
//         appBar: AppBar(
//           //// automaticallyImplyLeading: false,
//           title: Text(
//             'Profile'.tr,
//             style: GoogleFonts.poppins(
//               color: Colors.black,
//               fontSize: 22,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//
//           backgroundColor: AppColors.secondary.withOpacity(0.8),
//           elevation: 2,
//           centerTitle: true,
//           iconTheme: const IconThemeData(color:AppColors.backgroundColor),
//         ),
//         body: SingleChildScrollView(
//           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Stack(
//                 alignment: Alignment.bottomRight,
//                 children: [
//                   Container(
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       gradient: LinearGradient(
//                         colors: [
//                           const Color(0xFFe4b201),
//                           const Color(0xFFe4b201).withOpacity(0.6),
//                         ],
//                         begin: Alignment.topLeft,
//                         end: Alignment.bottomRight,
//                       ),
//                       boxShadow: [
//                         BoxShadow(
//                           color: primaryColor.withOpacity(0.2),
//                           blurRadius: 8,
//                           offset: const Offset(0, 4),
//                         ),
//                       ],
//                     ),
//                     padding: const EdgeInsets.all(4),
//                     child: CircleAvatar(
//                       radius: 56,
//                       backgroundColor: cardColor,
//                     ),
//                   ),
//                   GestureDetector(
//                     onTap: () {
//                       // Edit profile picture logic
//                     },
//                     child: const CircleAvatar(
//                       radius: 18,
//                       backgroundColor: Color(0xFFe57c42),
//                       child: Icon(Icons.edit, size: 20, color: Colors.white),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 20),
//               Text(
//                 controller.name.value,
//                 style: GoogleFonts.poppins(
//                   fontSize: 26,
//                   fontWeight: FontWeight.w700,
//                   color: primaryColor,
//                 ),
//               ),
//               const SizedBox(height: 6),
//               Text(
//                 controller.email.value,
//                 style: GoogleFonts.poppins(
//                   fontSize: 16,
//                   color: primaryColor.withOpacity(0.7),
//                 ),
//               ),
//               const SizedBox(height: 6),
//               Text(
//                 controller.phone.value,
//                 style: GoogleFonts.poppins(
//                   fontSize: 16,
//                   color: primaryColor.withOpacity(0.7),
//                 ),
//               ),
//               const SizedBox(height: 32),
//               _buildOptionTile(
//                 icon: Icons.edit,
//                 label: 'get_started'.tr,
//                 onTap: () {},
//               ),
//               _buildOptionTile(
//                 icon: Icons.list_alt,
//                 label: 'My Listings',
//                 onTap: () {},
//               ),
//               _buildOptionTile(
//                 icon: Icons.privacy_tip,
//                 label: 'Privacy & Policy',
//                 onTap: () {},
//               ),
//               _buildOptionTile(
//                 icon: Icons.logout,
//                 label: 'Logout',
//                 onTap: controller.logout,
//               ),
//               _buildOptionTile(
//                 icon: Icons.language,
//                 label: 'LanguageSelectionScreen',
//                 onTap: () {
//                   Get.to(() => LanguageSelectionScreen());
//                 },
//               ),
//             ],
//           ),
//         ),
//
//       //   bottomNavigationBar: CustomBottomNavigationBar(
//       //   currentIndex: _selectedIndex,
//       //   toggleTheme: () {  }, primaryColor: AppColors.secondary, bottomNavbarColor: AppColors.primary, cardColor: AppColors.backgroundColor,  // Pass callback here
//       // ),
//
//       );
//     });
//   }
//
//
//   Widget _buildOptionTile({
//     required IconData icon,
//     required String label,
//     required VoidCallback onTap,
//     Color? color,
//   }) {
//     return GestureDetector(
//       onTap: onTap,
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 200),
//         margin: const EdgeInsets.symmetric(vertical: 10),
//         decoration: BoxDecoration(
//           color: cardColor,
//           border: Border.all(color: const Color(0xFFe4b201), width: 1.5),
//           borderRadius: BorderRadius.circular(16),
//           boxShadow: [
//             BoxShadow(
//               color: const Color(0xFFe57c42).withOpacity(0.1),
//               blurRadius: 10,
//               offset: const Offset(0, 4),
//             ),
//           ],
//         ),
//         child: ListTile(
//           contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//           leading: CircleAvatar(
//             radius: 24,
//             backgroundColor: const Color(0xFFe57c42),
//             child: Icon(icon, color: color ?? Colors.white, size: 26),
//           ),
//           title: Text(
//             label,
//             style: GoogleFonts.poppins(
//               color: color ?? primaryColor,
//               fontSize: 16,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//           trailing: const Icon(Icons.arrow_forward_ios, size: 18, color: Color(0xFFe57c42)),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:madhanvasu_app/Feature-based/profile/privacy_policys/Privacy_policy_screen.dart';

import 'package:madhanvasu_app/Feature-based/profile/profile_controller/profile_controller.dart';
import 'package:madhanvasu_app/Feature-based/app_Language/app_language_screen.dart';
import 'package:madhanvasu_app/Feature-based/profile/terms&Conditions/terms&Conditions_screen.dart';
import '../../../utils/shared_pref_helper.dart';
import '../../app/configuration/ themes/app_colors.dart';
import '../../app/routes/app_routes.dart';
import '../../madhanvasu_lib/aswini_screens/property_listings.dart';
import '../../utils/Common_buttons&widgets/AppLoding_widget.dart';
import '../MY_properties_list/my_property_list_screen.dart';
import 'about_us/Aboutus_screen.dart';
import 'edit_profile/edit_profileScreen.dart';
import 'edit_profile/edit_profile_controller.dart';


class ProfileDetails extends GetView<ProfileController> {
  const ProfileDetails({super.key});
  final int _selectedIndex = 3;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Scaffold(
          backgroundColor: AppColors.backgroundColorProfile,
          body: Center(child: CustomLoader()),
        );
      }

      return Scaffold(
        // backgroundColor: const Color(0xFFFFFDE7),

        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          // backgroundColor: AppColors.secondary.withOpacity(0.8),
          // backgroundColor: widget.cardColor,

        elevation: 2,
          centerTitle: true,
          iconTheme: const IconThemeData(color: AppColors.primary),
          title: Text(
            'profile'.tr,
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  builder: (context) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(Icons.logout, color: Colors.redAccent, size: 40),
                        const SizedBox(height: 16),

                        const Text(
                          "Logout",
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),

                        const SizedBox(height: 12),

                        const Text(
                          "Are you sure you want to log out?",
                          style: TextStyle(fontSize: 16, color: Colors.black87),
                          textAlign: TextAlign.center,
                        ),

                        const SizedBox(height: 28),

                        Row(
                          children: [
                            // Cancel Button
                            Expanded(
                              child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(vertical: 14),
                                  side: BorderSide(color: Colors.grey.shade400),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                onPressed: () => Navigator.pop(context),
                                child: const Text("Cancel"),
                              ),
                            ),
                            const SizedBox(width: 12),

                            // Logout Button
                            Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.redAccent,
                                  padding: const EdgeInsets.symmetric(vertical: 14),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.pop(context); // Close the dialog
                                  Get.offAllNamed('/login'); // Navigate to login
                                },
                                child: const Text("Logout", style: TextStyle(color: Colors.white)),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            )
          ],
        ),
        body: RefreshIndicator(
          onRefresh: controller.fetchUserData,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Profile Image + Edit
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [
                            AppColors.secondary,
                            AppColors.secondary.withOpacity(0.6),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withOpacity(0.2),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        radius: 56,
                        backgroundColor: AppColors.cardColor,
                        // backgroundImage: controller.profileImage.value.isNotEmpty
                        //     ? NetworkImage(controller.profileImage.value)
                        //     : null,
                        // child: controller.profileImage.value.isEmpty
                        //     ? const Icon(Icons.person, size: 50, color: Colors.grey)
                        //     : null,
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        final Map<String, String> userData = {};
                        for (var key in SharedPrefHelper.userKeys) {
                          final value = await SharedPrefHelper.getUserData(key);
                          userData[key] = value ?? '';
                        }

                        final editController = Get.put(EditProfileController());
                        editController.loadInitialData(userData);
                        final result = await Get.to(() => EditProfileScreen());
                        if (result == true) {
                          controller.fetchUserData();
                        }
                      },
                      child: const CircleAvatar(
                        radius: 18,
                        backgroundColor: AppColors.primary,
                        child: Icon(Icons.edit, size: 20, color: AppColors.cardColor),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),
                // Name
                Text(
                  controller.name.value,
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                ),

                const SizedBox(height: 6),
                Text(
                  controller.email.value,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.black.withOpacity(0.6),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  controller.phone.value,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.black.withOpacity(0.6),
                  ),
                ),

                const SizedBox(height: 32),
                _buildOptionTile(
                  icon: Icons.list_alt,
                  label: 'My Listings'.tr,
                  onTap: () {
                    Get.toNamed(AppRoutes.My_Property_Screen);
                  },
                ),
                _buildOptionTile(
                  icon: Icons.privacy_tip,
                  label: 'Privacy Policy'.tr,
                  onTap: () {
                    Get.to(() => const PrivacyPolicyScreen());
                  },
                ),
                _buildOptionTile(
                  icon: Icons.article_rounded,
                  label: 'Terms Conditions'.tr,
                  onTap: () {
                    Get.to(() => const TermsConditionsScreen());
                  },
                ),
                _buildOptionTile(
                  icon: Icons.info_outline,
                  label: 'About Us'.tr,
                  onTap: () {
                    Get.to(() => const AboutUsScreen());
                  },
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildOptionTile({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    Color? color,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.cardColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.secondary, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.08),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          leading: CircleAvatar(
            radius: 24,
            backgroundColor: AppColors.primary,
            child: Icon(icon, color: color ?? Colors.white, size: 24),
          ),
          title: Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColors.primaryColor,
            ),
          ),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.primary),
        ),
      ),
    );
  }
}


