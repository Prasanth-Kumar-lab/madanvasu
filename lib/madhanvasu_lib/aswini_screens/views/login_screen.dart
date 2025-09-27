// import 'package:flutter/material.dart';
// import 'package:animate_do/animate_do.dart';
// import 'package:provider/provider.dart';
//
// import '../../../Feature-based/auth/login_controller/login_controller.dart';
// import '../foget_password.dart';
// import '../home_page.dart';
// import '../registration_screen.dart';
// // import 'package:real_estate/aswini_screens/constants/Colors.dart';
// // import 'package:real_estate/aswini_screens/controllers/login_controller.dart';
// // import 'package:real_estate/aswini_screens/home_page.dart';
// // import 'package:real_estate/aswini_screens/registration_screen.dart';
// // import 'package:real_estate/aswini_screens/foget_password.dart';
// // Adjust import if needed
//
// class Login_Screen extends StatefulWidget {
//   final VoidCallback toggleTheme;
//
//   const Login_Screen({super.key, required this.toggleTheme});
//
//   @override
//   _Login_ScreenState createState() => _Login_ScreenState();
// }
//
// class _Login_ScreenState extends State<Login_Screen> {
//   final _nameController = TextEditingController();
//   final _passwordController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();
//   bool _obscurePassword = true;
//   // String? _fcmToken; // Commented out as FCM token is no longer needed
//
//   @override
//   void initState() {
//     super.initState();
//     // _initFcmToken(); // Commented out as FCM token is no longer needed
//   }
//
//   // Future<void> _initFcmToken() async {
//   //   _fcmToken = await FirebaseMessaging.instance.getToken();
//   //   setState(() {});
//   // }
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
//     final loginController = Provider.of<LoginController>(context);
//     return Scaffold(
//       backgroundColor: Colors.transparent,
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [
//               Color(0xFFFFF5E4),
//               Color(0xFFFFF5E4),
//             ],
//           ),
//         ),
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.only(top: 100, bottom: 100),
//             child: Column(
//               children: [
//                 FadeInUp(
//                   duration: const Duration(milliseconds: 1800),
//                   child: Image.asset(
//                     'assets/App_logo.png',
//                     height: 150,
//                     width: 200,
//                     // errorBuilder: (context, error, stackTrace) => Icon(
//                     //   Icons.sports_tennis,
//                     //   size: 150,
//                     //   color: AppColors.primary.withOpacity(0.2),
//                     // ),
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
//                           child: ClipRRect(
//                             borderRadius: BorderRadius.circular(30.0),
//                             child: Container(
//                               padding: const EdgeInsets.all(5),
//                               decoration: BoxDecoration(
//                                 color: const Color(0xFFFFF5E4),
//                                 borderRadius: BorderRadius.circular(30.0),
//                                 border: Border.all(
//                                   color: const Color(0xFFfab783),
//                                   width: 1.5,
//                                 ),
//                               ),
//                               child: Container(
//                                 padding: const EdgeInsets.all(4.0),
//                                 child: TextFormField(
//                                   controller: _nameController,
//                                   validator: (value) {
//                                     if (value == null || value.trim().isEmpty) {
//                                       return 'Please enter your email or phone number';
//                                     }
//                                     return null;
//                                   },
//                                   decoration: InputDecoration(
//                                     border: InputBorder.none,
//                                     hintText: "Email or Phone number",
//                                     hintStyle: TextStyle(color: Colors.grey[700]),
//                                     prefixIcon: const Icon(
//                                       Icons.email,
//                                       color: Color(0xFFe57c42),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(height: 20),
//                         FadeInUp(
//                           duration: const Duration(milliseconds: 1800),
//                           child: ClipRRect(
//                             borderRadius: BorderRadius.circular(30.0),
//                             child: Container(
//                               padding: const EdgeInsets.all(5),
//                               decoration: BoxDecoration(
//                                 color: const Color(0xFFFFF5E4),
//                                 borderRadius: BorderRadius.circular(30.0),
//                                 border: Border.all(
//                                   color: const Color(0xFFfab783),
//                                   width: 1.5,
//                                 ),
//                               ),
//                               child: Container(
//                                 padding: const EdgeInsets.all(4.0),
//                                 child: TextFormField(
//                                   controller: _passwordController,
//                                   obscureText: _obscurePassword,
//                                   validator: (value) {
//                                     if (value == null || value.isEmpty) {
//                                       return 'Please enter your password';
//                                     } else if (value.length < 2) {
//                                       return 'Password must be at least 2 characters';
//                                     }
//                                     return null;
//                                   },
//                                   decoration: InputDecoration(
//                                     border: InputBorder.none,
//                                     hintText: "Password",
//                                     hintStyle: TextStyle(color: Colors.grey[700]),
//                                     prefixIcon: const Icon(
//                                       Icons.lock,
//                                       color: Color(0xFFe57c42),
//                                     ),
//                                     suffixIcon: IconButton(
//                                       icon: Icon(
//                                         _obscurePassword
//                                             ? Icons.visibility_off
//                                             : Icons.visibility,
//                                         color: const Color(0xFFe57c42),
//                                       ),
//                                       onPressed: () {
//                                         setState(() {
//                                           _obscurePassword = !_obscurePassword;
//                                         });
//                                       },
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(height: 30),
//                         FadeInUp(
//                           duration: const Duration(milliseconds: 2000),
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: ElevatedButton(
//                               onPressed: loginController.isLoading
//                                   ? null
//                                   : () => _handleLogin(loginController),
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: const Color(0xFFe57c42),
//                                 foregroundColor: Colors.white,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(30),
//                                 ),
//                                 padding: const EdgeInsets.symmetric(vertical: 15),
//                                 minimumSize: const Size(double.infinity, 50),
//                                 elevation: 5,
//                               ),
//                               child: AnimatedSwitcher(
//                                 duration: const Duration(milliseconds: 300),
//                                 child: loginController.isLoading
//                                     ? const SizedBox(
//                                         height: 20,
//                                         width: 20,
//                                         child: CircularProgressIndicator(
//                                           color: Colors.white,
//                                           strokeWidth: 2,
//                                         ),
//                                       )
//                                     : const Text(
//                                         "Login",
//                                         style: TextStyle(
//                                           color: Colors.white,
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 16,
//                                         ),
//                                       ),
//                               ),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(height: 20),
//                         FadeInUp(
//                           duration: const Duration(milliseconds: 2000),
//                           child: Padding(
//                             padding: const EdgeInsets.only(bottom: 100),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 TextButton(
//                                   onPressed: () {
//                                     Navigator.pushReplacement(
//                                       context,
//                                       MaterialPageRoute(
//                                           builder: (context) =>
//                                               const ForgetPasswordPage()),
//                                     );
//                                   },
//                                   child: const Text(
//                                     "Forgot Password?",
//                                     style: TextStyle(color: Color(0xFFe57c42)),
//                                   ),
//                                 ),
//                                 TextButton(
//                                   onPressed: () {
//                                     Navigator.pushReplacement(
//                                       context,
//                                       MaterialPageRoute(
//                                           builder: (context) =>
//                                               const RegistrationScreen()),
//                                     );
//                                   },
//                                   child: const Text(
//                                     "Sign Up",
//                                     style: TextStyle(color: Color(0xFFe57c42)),
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
//   Future<void> _handleLogin(LoginController loginController) async {
//   if (_formKey.currentState!.validate()) {
//     try {
//       // Ensure the UI reflects the loading state
//       loginController.setLoading(true);
//
//       // Call loginUser without FCM token
//       bool success = await loginController.loginUser(
//         _nameController.text.trim(),
//         _passwordController.text.trim(),
//       );
//
//       if (!mounted) return;
//
//       // Reset loading state
//       loginController.setLoading(false);
//
//       if (success) {
//         _showSuccessAnimation();
//         await Future.delayed(const Duration(milliseconds: 1500));
//         if (!mounted) return;
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (_) => RealEstateHomeScreen()),
//         );
//       } else {
//         _showErrorSnackBar("Login Failed: Invalid credentials or server issue");
//       }
//     } catch (e, stackTrace) {
//       if (!mounted) return;
//       // Reset loading state on error
//       loginController.setLoading(false);
//       _showErrorSnackBar("Login Error: ${e.toString()}");
//       // Log the error for debugging
//       debugPrint("Login Error: $e\nStackTrace: $stackTrace");
//     }
//   }
// }
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
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               TweenAnimationBuilder<double>(
//                 tween:  Tween(begin: 0.0, end: 1.0),
//                 duration: const Duration(milliseconds: 800),
//                 builder: (context, value, child) {
//                   return Transform.scale(
//                     scale: value,
//                     child: Container(
//                       padding: const EdgeInsets.all(16),
//                       decoration: BoxDecoration(
//                         color: Color(0xFFe57c42),
//                         shape: BoxShape.circle,
//                       ),
//                       child: const Icon(
//                         Icons.check,
//                         color: Colors.white,
//                         size: 20,
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ],
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