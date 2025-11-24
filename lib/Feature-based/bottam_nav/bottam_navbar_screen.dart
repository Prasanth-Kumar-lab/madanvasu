import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:madhanvasu_app/app/routes/app_routes.dart';
import '../../../app/configuration/themes/app_colors.dart';
import '../Notifications/notification_screen.dart';
import '../post_property_feature/post_property_screen.dart';
import '../profile/about_us/Aboutus_screen.dart';
import '../profile/privacy_policys/Privacy_policy_screen.dart';
import '../profile/terms&Conditions/terms&Conditions_screen.dart';
import '../states&districts/states/states_controller.dart';
import '../states&districts/districts/distric_controller.dart';
import '../states&districts/mandals/mandals_controller.dart';
import '../states&districts/villages/villages_controller.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final VoidCallback toggleTheme;
  final Color primaryColor;
  final Color bottomNavbarColor;
  final Color cardColor;

  const CustomBottomNavigationBar({
    Key? key,
    required this.currentIndex,
    required this.toggleTheme,
    required this.primaryColor,
    required this.bottomNavbarColor,
    required this.cardColor,
  }) : super(key: key);

  void navigateToCreatePropertyScreen(BuildContext context) {
    Get.put(StateController());
    Get.put(DistrictController());
    Get.put(MandalController());
    Get.put(VillageController());

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CreateProperty_Screen(),
      ),
    );

  }

  void _handleNavigation(BuildContext context, int index) {
    switch (index) {
      case 0:
        Get.offAllNamed('/home');
        break;
      case 1:
        Get.toNamed(AppRoutes.savedproperties);
        break;
      case 2:
      // Use navigateToCreatePropertyScreen to ensure controllers are initialized
        navigateToCreatePropertyScreen(context);
        break;
      case 3:
        _showProfileBottomSheet(context);
        break;
    }
  }

  void _showProfileBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.backgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.55,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Account Options',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 4,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 28,
                    children: [
                      _buildOption(
                        icon: Icons.account_circle,
                        label: 'Profile',
                        color: Colors.orange,
                        onTap: () {
                          Navigator.pop(context);
                          Get.toNamed('/profile');
                        },
                      ),
                      _buildOption(
                        icon: Icons.notifications,
                        label: 'Alerts',
                        color: Colors.orange,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NotificationsScreen()),
                          );
                        },
                      ),
                      _buildOption(
                        icon: Icons.info_outline,
                        label: 'About Us',
                        color: Colors.orange,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AboutUsScreen()),
                          );
                        },
                      ),
                      _buildOption(
                        icon: Icons.lock_outline,
                        label: 'Privacy',
                        color: Colors.orange,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PrivacyPolicyScreen()),
                          );
                        },
                      ),
                      _buildOption(
                        icon: Icons.description,
                        label: 'Terms',
                        color: Colors.orange,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TermsConditionsScreen()),
                          );
                        },
                      ),
                      _buildOption(
                        icon: Icons.description,
                        label: 'My Properties',
                        color: Colors.orange,
                        onTap: () {
                          Get.toNamed(AppRoutes.My_Property_Screen);
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    icon: const Icon(Icons.logout, color: Colors.white),
                    label: const Text(
                      'Logout',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              title: Row(
                                children: const [
                                  Icon(Icons.logout, color: Colors.redAccent),
                                  SizedBox(width: 8),
                                  Text("Confirm Logout",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ],
                              ),
                              content: const Text(
                                "Are you sure you want to log out?",
                                style: TextStyle(fontSize: 14),
                              ),
                              actionsPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                              actions: [
                                // Cancel Button
                                TextButton(
                                  style: TextButton.styleFrom(
                                    foregroundColor: Colors.grey[700],
                                    textStyle: const TextStyle(fontSize: 16),
                                  ),
                                  child: const Text("Cancel"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),

                                // Logout Button
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.redAccent,
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: const Text("Logout", style: TextStyle(fontSize: 16)),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    Navigator.pop(context);
                                    Get.offAllNamed('/login');
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Reusable grid item widget
  Widget _buildOption({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: color.withOpacity(0.1),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(height: 6),
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) => _handleNavigation(context, index),
      selectedItemColor: bottomNavbarColor,
      unselectedItemColor: bottomNavbarColor.withOpacity(0.9),
      backgroundColor: cardColor,
      type: BottomNavigationBarType.fixed,
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
      unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
      elevation: 8,
      items: [
        BottomNavigationBarItem(
          icon: const Icon(Icons.home_outlined, size: 30),
          label: 'Home',
          activeIcon: Icon(Icons.home, size: 28, color: primaryColor),
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.favorite_border, size: 28),
          label: 'Saved',
          activeIcon: Icon(Icons.favorite, size: 28, color: primaryColor),
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.post_add_outlined, size: 28),
          label: 'Post',
          activeIcon: Icon(Icons.post_add, size: 28, color: primaryColor),
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.menu, size: 28),
          label: 'More',
          activeIcon: Icon(Icons.menu, size: 28, color: primaryColor),
        ),
      ],
    );
  }
}