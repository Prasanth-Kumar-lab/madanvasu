// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:animate_do/animate_do.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import '../../../Feature-based/auth/login_controller/login_controller.dart';
// import '../../../app/configuration/ themes/app_colors.dart';
// import '../../../app/routes/app_routes.dart';
// import '../../../madhanvasu_lib/aswini_screens/home_page.dart';
// import '../../../utils/Common_buttons&widgets/CustomButton.dart';
//
// class Login_Screen extends StatefulWidget {
//   final VoidCallback toggleTheme;
//
//   const Login_Screen({super.key, required this.toggleTheme});
//
//   @override
//   State<Login_Screen> createState() => _Login_ScreenState();
// }
//
// class _Login_ScreenState extends State<Login_Screen> {
//   final _nameController = TextEditingController();
//   final _passwordController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();
//   bool _obscurePassword = true;
//
//   final LoginController loginController = Get.put(LoginController());
//
//   String? _fcmToken;
//
//   @override
//   void initState() {
//     super.initState();
//     _initFcmToken();
//   }
//
//   Future<void> _initFcmToken() async {
//     try {
//       NotificationSettings settings = await FirebaseMessaging.instance.requestPermission();
//
//       if (settings.authorizationStatus == AuthorizationStatus.authorized ||
//           settings.authorizationStatus == AuthorizationStatus.provisional) {
//         _fcmToken = await FirebaseMessaging.instance.getToken();
//         print('FCM Token: $_fcmToken');
//       } else {
//         print('FCM permission not granted.');
//       }
//     } catch (e) {
//       print('Failed to get FCM token: $e');
//     }
//   }
//
//   @override
//   void dispose() {
//     _nameController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.transparent,
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [Color(0xFFFFF5E8), Color(0xFFFFF599)],
//           ),
//         ),
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.only(top: 100, bottom: 120),
//             child: Column(
//               children: [
//                 FadeInUp(
//                   duration: const Duration(milliseconds: 1800),
//                   child: Image.asset(
//                     'assets/App_logo.png',
//                     height: 150,
//                     width: 200,
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
//                   child: Form(
//                     key: _formKey,
//                     child: Column(
//                       children: [
//                         FadeInUp(
//                           duration: const Duration(milliseconds: 1800),
//                           child: _buildTextField(
//                             controller: _nameController,
//                             hintText: "Email or Phone number",
//                             icon: Icons.email,
//                             validator: (value) {
//                               if (value == null || value.trim().isEmpty) {
//                                 return 'Please enter your email or phone number';
//                               }
//                               return null;
//                             },
//                           ),
//                         ),
//                         const SizedBox(height: 25),
//                         FadeInUp(
//                           duration: const Duration(milliseconds: 1800),
//                           child: _buildTextField(
//                             controller: _passwordController,
//                             hintText: "Password",
//                             icon: Icons.lock,
//                             obscureText: _obscurePassword,
//                             suffixIcon: IconButton(
//                               icon: Icon(
//                                 _obscurePassword ? Icons.visibility_off : Icons.visibility,
//                                 color: AppColors.primary,
//                               ),
//                               onPressed: () {
//                                 setState(() {
//                                   _obscurePassword = !_obscurePassword;
//                                 });
//                               },
//                             ),
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'Please enter your password';
//                               } else if (value.length < 2) {
//                                 return 'Password must be at least 2 characters';
//                               }
//                               return null;
//                             },
//                           ),
//                         ),
//                         const SizedBox(height: 30),
//                         FadeInUp(
//                           duration: const Duration(milliseconds: 2000),
//                           child: Obx(() => CustomButton(
//                             text: "Login",
//                             isLoading: loginController.isLoading.value,
//                             onPressed: _handleLogin,
//                             backgroundColor: AppColors.primary,
//                             width: 200, ///
//                             // height: 100,
//                             borderRadius: 10.0,
//                           ))
//
//
//                           ),
//                         const SizedBox(height: 20),
//                         FadeInUp(
//                           duration: const Duration(milliseconds: 2000),
//                           child: Padding(
//                             padding: const EdgeInsets.only(bottom: 100),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 TextButton(
//                                   onPressed: () => Get.toNamed(AppRoutes.ForgetPassword),
//                                   child: const Text(
//                                     "Forgot Password?",
//                                     style: TextStyle(color: AppColors.primary),
//                                   ),
//                                 ),
//                                 TextButton(
//                                   onPressed: () => Get.toNamed(AppRoutes.register),
//                                   child: const Text(
//                                     "Sign Up",
//                                     style: TextStyle(color: AppColors.primary),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildTextField({
//     required TextEditingController controller,
//     required String hintText,
//     required IconData icon,
//     bool obscureText = false,
//     Widget? suffixIcon,
//     String? Function(String?)? validator,
//   }) {
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(30.0),
//       child: Container(
//         padding: const EdgeInsets.all(5),
//         decoration: BoxDecoration(
//           color: const Color(0xFFFFF5E4),
//           borderRadius: BorderRadius.circular(30.0),
//           border: Border.all(color: AppColors.border, width: 1.5),
//         ),
//         child: Container(
//           padding: const EdgeInsets.all(4.0),
//           child: TextFormField(
//             controller: controller,
//             obscureText: obscureText,
//             validator: validator,
//             decoration: InputDecoration(
//               border: InputBorder.none,
//               hintText: hintText,
//               hintStyle: TextStyle(color: Colors.grey[700]),
//               prefixIcon: Icon(icon, color: AppColors.primary),
//               suffixIcon: suffixIcon,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Future<void> _handleLogin() async {
//     if (_formKey.currentState!.validate()) {
//       try {
//         loginController.setLoading(true);
//
//         bool success = await loginController.loginUser(
//           _nameController.text.trim(),
//           _passwordController.text.trim(),
//           _fcmToken ?? '',
//         );
//
//         loginController.setLoading(false);
//
//         if (success) {
//           _showSuccessAnimation();
//           await Future.delayed(const Duration(milliseconds: 1500));
//           if (!mounted) return;
//           Get.offAll(() => RealEstateHomeScreen()); ////////////////
//         } else {
//           _showErrorSnackBar("Login failed: Invalid credentials");
//         }
//       } catch (e, stackTrace) {
//         loginController.setLoading(false);
//         _showErrorSnackBar("Login Error: ${e.toString()}");
//         debugPrint("Login Error: $e\nStackTrace: $stackTrace");
//       }
//     }
//   }
//
//
//
//   void _showSuccessAnimation() {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (context) => Center(
//         child: Container(
//           padding: const EdgeInsets.all(20),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(15),
//           ),
//           child: TweenAnimationBuilder<double>(
//             tween: Tween(begin: 0.0, end: 1.0),
//             duration: const Duration(milliseconds: 800),
//             builder: (context, value, child) {
//               return Transform.scale(
//                 scale: value,
//                 child: Container(
//                   padding: const EdgeInsets.all(16),
//                   decoration: const BoxDecoration(
//                     color: AppColors.primary,
//                     shape: BoxShape.circle,
//                   ),
//                   child: const Icon(Icons.check, color: Colors.white, size: 20),
//                 ),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
//
//   void _showErrorSnackBar(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Row(
//           children: [
//             const Icon(Icons.error, color: Colors.white),
//             const SizedBox(width: 8),
//             Text(message),
//           ],
//         ),
//         backgroundColor: Colors.red,
//         behavior: SnackBarBehavior.floating,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(10),
//         ),
//       ),
//     );
//   }
// }




import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animate_do/animate_do.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:google_sign_in/google_sign_in.dart'; // <-- Added for Google Sign-In
import '../../../Feature-based/auth/login_controller/login_controller.dart';
import '../../../app/configuration/ themes/app_colors.dart';
import '../../../app/routes/app_routes.dart';
import '../../home/home/home_page.dart';
import '../../../utils/Common_buttons&widgets/CustomButton.dart';

class Login_Screen extends StatefulWidget {
  final VoidCallback toggleTheme;

  const Login_Screen({super.key, required this.toggleTheme});

  @override
  State<Login_Screen> createState() => _Login_ScreenState();
}

class _Login_ScreenState extends State<Login_Screen> {
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;

  final LoginController loginController = Get.put(LoginController());

  String? _fcmToken;

  // Google Sign-In instance
  final GoogleSignIn _googleSignIn = GoogleSignIn.standard(scopes: ['email']);

  // Loading indicator for Google sign-in
  bool _isGoogleLoading = false;

  @override
  void initState() {
    super.initState();
    _initFcmToken();
  }

  Future<void> _initFcmToken() async {
    try {
      NotificationSettings settings = await FirebaseMessaging.instance.requestPermission();

      if (settings.authorizationStatus == AuthorizationStatus.authorized ||
          settings.authorizationStatus == AuthorizationStatus.provisional) {
        _fcmToken = await FirebaseMessaging.instance.getToken();
        print('FCM Tokennnn: $_fcmToken');
      } else {
        print('FCM permission not granted.');
      }
    } catch (e) {
      print('Failed to get FCM token: $e');
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFFFF5E8), Color(0xFFFFF599)],
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 100, bottom: 120),
            child: Column(
              children: [
                FadeInUp(
                  duration: const Duration(milliseconds: 1800),
                  child: Image.asset(
                    'assets/App_logo.png',
                    height: 150,
                    width: 200,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        FadeInUp(
                          duration: const Duration(milliseconds: 1800),
                          child: _buildTextField(
                            controller: _nameController,
                            keyboardType: TextInputType.phone,
                            hintText: " Phone number",
                            icon: Icons.phone,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Please enter your phone number';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 25),
                        FadeInUp(
                          duration: const Duration(milliseconds: 1800),
                          child: _buildTextField(
                            controller: _passwordController,
                            hintText: "Password",
                            icon: Icons.lock,
                            obscureText: _obscurePassword,
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword ? Icons.visibility_off : Icons.visibility,
                                color: AppColors.primary,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              } else if (value.length < 2) {
                                return 'Password must be at least 2 characters';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 30),
                        FadeInUp(
                          duration: const Duration(milliseconds: 2000),
                          child: Obx(() => CustomButton(
                            text: "Login",
                            isLoading: loginController.isLoading.value,
                            onPressed: _handleLogin,
                            backgroundColor: AppColors.primary,
                            width: 200,
                            borderRadius: 10.0,
                          )),
                        ),
                        const SizedBox(height: 20),

                        // Google Sign-In button with animation
                        // FadeInUp(
                        //   duration: const Duration(milliseconds: 2200),
                        //   child: _isGoogleLoading
                        //       ? const CircularProgressIndicator()
                        //       : GestureDetector(
                        //     onTap: _handleGoogleSignIn,
                        //     child: Container(
                        //       width: 200,
                        //       height: 50,
                        //       decoration: BoxDecoration(
                        //         color: Colors.white,
                        //         borderRadius: BorderRadius.circular(10),
                        //         boxShadow: [
                        //           BoxShadow(
                        //             color: Colors.grey.withOpacity(0.4),
                        //             blurRadius: 6,
                        //             offset: const Offset(0, 3),
                        //           ),
                        //         ],
                        //       ),
                        //       child: Row(
                        //         mainAxisAlignment: MainAxisAlignment.center,
                        //         children: [
                        //           Image.asset(
                        //             'assets/App_logo.png',
                        //             height: 24,
                        //             width: 24,
                        //           ),
                        //           const SizedBox(width: 12),
                        //           const Text(
                        //             'Sign in with Google',
                        //             style: TextStyle(
                        //               color: Colors.black87,
                        //               fontSize: 16,
                        //               fontWeight: FontWeight.w600,
                        //             ),
                        //           ),
                        //         ],
                        //       ),
                        //     ),
                        //   ),
                        // ),

                        // const SizedBox(height: 20),

                        FadeInUp(
                          duration: const Duration(milliseconds: 2000),
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 100),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                  onPressed: () => Get.toNamed(AppRoutes.ForgetPassword),
                                  child: const Text(
                                    "Forgot Password?",
                                    style: TextStyle(color: AppColors.primary),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () => Get.toNamed(AppRoutes.register),
                                  child: const Text(
                                    "Sign Up",
                                    style: TextStyle(color: AppColors.primary),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    bool obscureText = false,
    Widget? suffixIcon,
    String? Function(String?)? validator,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30.0),
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: const Color(0xFFFFF5E4),
          borderRadius: BorderRadius.circular(30.0),
          border: Border.all(color: AppColors.border, width: 1.5),
        ),
        child: Container(
          padding: const EdgeInsets.all(4.0),
          child: TextFormField(
            controller: controller,
            obscureText: obscureText,
            validator: validator,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintText,
              hintStyle: TextStyle(color: Colors.grey[700]),
              prefixIcon: Icon(icon, color: AppColors.primary),
              suffixIcon: suffixIcon,
            ),
          ),
        ),
      ),
    );
  }


  Future<void> _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      try {
        loginController.setLoading(true);

        bool success = await loginController.loginUser(
          _nameController.text.trim(),
          _passwordController.text.trim(),
          _fcmToken ?? '',
        );

        loginController.setLoading(false);

        if (success) {
          _showSuccessAnimation();
          await Future.delayed(const Duration(milliseconds: 1500));
          if (!mounted) return;
          Get.offAll(() => RealEstateHomeScreen());
        } else {
          _showErrorSnackBar("Login failed: Invalid credentials");
        }
      } catch (e, stackTrace) {
        loginController.setLoading(false);
        _showErrorSnackBar("Login Error: ${e.toString()}");
        debugPrint("Login Error: $e\nStackTrace: $stackTrace");
      }
    }
  }

  Future<void> _handleGoogleSignIn() async {
    setState(() {
      _isGoogleLoading = true;
    });

    try {
      final GoogleSignInAccount? account = await _googleSignIn.signIn();

      if (account != null) {
        debugPrint('Google SignIn successful: ${account.email}');
        // Proceed with your login flow or backend verification

        Get.offAll(() => const RealEstateHomeScreen());
      } else {
        debugPrint('Google SignIn aborted by user');
      }
    } catch (error) {
      debugPrint('Google SignIn error: $error');
      _showErrorSnackBar('Google sign-in failed. Please try again.');
    } finally {
      if (mounted) {
        setState(() {
          _isGoogleLoading = false;
        });
      }
    }
  }

  void _showSuccessAnimation() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.0, end: 1.0),
            duration: const Duration(milliseconds: 800),
            builder: (context, value, child) {
              return Transform.scale(
                scale: value,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.check, color: Colors.white, size: 20),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error, color: Colors.white),
            const SizedBox(width: 8),
            Text(message),
          ],
        ),
        backgroundColor: Colors.red.shade700,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
