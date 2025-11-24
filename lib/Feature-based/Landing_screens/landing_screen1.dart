// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:madhanvasu_app/app/configuration/%20themes/app_colors.dart';
//
// import '../../app/routes/app_routes.dart';
// import '../../utils/Common_buttons&widgets/CustomButton.dart';
// import 'landing_screen2.dart';
//
// class Landing_screen_1 extends StatelessWidget {
//   const Landing_screen_1({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: const BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage('assets/designed image.png'),
//             fit: BoxFit.cover,
//             opacity: 0.6,
//           ),
//         ),
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Image.asset(
//                 'assets/mlogo.jpg',
//                 height: 200,
//                 width: 300,
//               ),
//               const SizedBox(height: 20),
//               const Padding(
//                 padding: EdgeInsets.only(left: 40),
//                 child: Text(
//                   'Post Property for just Two Rupees',
//                   style: TextStyle(
//                     fontSize: 30,
//                     fontWeight: FontWeight.bold,
//                     color: Color(0xFFe57c42),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 10),
//               const Padding(
//                 padding: EdgeInsets.only(left: 30, right: 20),
//                 child: Text(
//                   'List your property at an unbeatable price of just ₹2.',
//                   style: TextStyle(
//                     fontSize: 16,
//                     color: Colors.black87
//
//                   ),
//                 ),
//               ),
//               const Padding(
//                 padding: EdgeInsets.only(left: 30, top: 10, right: 20),
//                 child: Text(
//                   'Reach thousands of potential buyers and renters instantly.',
//                   style: TextStyle(
//                     fontSize: 16,
//                     color: Colors.black87,
//
//                   ),
//                 ),
//               ),
//               const Padding(
//                 padding: EdgeInsets.only(left: 30, top: 10, right: 20),
//                 child: Text(
//                   'Start growing your real estate business today with ease.',
//                   style: TextStyle(
//                     fontSize: 16,
//                     color: Colors.black87,
//
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 30),
//               Center(
//                 // child: ElevatedButton(
//                 //   style: ElevatedButton.styleFrom(
//                 //     backgroundColor: const Color(0xFFe57c42),
//                 //   ),
//                 //   onPressed: () {
//                 //     // Navigator.push(
//                 //     //   context,
//                 //     //   MaterialPageRoute(builder: (context) => Landing_screen_2()),
//                 //     // );
//                 //     //
//                 //     Get.toNamed(AppRoutes.landing2);
//                 //
//                 //
//                 //   },
//                 //   child: const Text(
//                 //     'Skip',
//                 //     style: TextStyle(color: Colors.white, fontSize: 16),
//                 //   ),
//                 // ),
//                 child: CustomButton(
//                   text: 'Skip',
//                   isLoading: false,
//                   onPressed: () => Get.toNamed(AppRoutes.landing2),
//                   width: 120,
//                   height: 45,
//                   backgroundColor: AppColors.primary,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


/////////////


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/configuration/themes/app_colors.dart';
import '../../app/routes/app_routes.dart';
import '../../utils/Common_buttons&widgets/CustomButton.dart';

class Landing_screen_1 extends StatelessWidget {
  const Landing_screen_1({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/designed image.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Gradient Overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.white.withOpacity(0.9),
                  Colors.white.withOpacity(0.8),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          // Main Content
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 200,
                      width: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10,
                            offset: Offset(0, 6),
                          ),
                        ],
                        image: const DecorationImage(
                          image: AssetImage('assets/mlogo.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    // Title
                    Text(
                      'Post Property for just ₹5',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                        height: 1.3,
                      ),
                    ),

                    const SizedBox(height: 16),

                    _buildInfoText(
                        'List your property at an unbeatable price of just ₹5.'),
                    _buildInfoText(
                        'Reach thousands of potential buyers and renters instantly.'),
                    _buildInfoText(
                        'Start growing your real estate business today with ease.'),

                    const SizedBox(height: 40),

                    CustomButton(
                      text: 'Skip',
                      isLoading: false,
                      onPressed: () => Get.toNamed(AppRoutes.landing2),
                      width: 150,
                      height: 50,
                      borderRadius: 30,
                      backgroundColor: AppColors.primary,
                      // textStyle: const TextStyle(
                      //   fontSize: 18,
                      //   color: Colors.white,
                      //   fontWeight: FontWeight.w600,
                      // ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoText(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.black87,
          height: 1.5,
        ),
      ),
    );
  }
}
