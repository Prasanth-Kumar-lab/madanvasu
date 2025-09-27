
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:madhanvasu_app/app/configuration/%20themes/app_colors.dart';
// import '../../Common_buttons&widgets/CustomButton.dart';
// import '../../app/routes/app_routes.dart';
// import '../splash_screen/splashscreen.dart';
//
// class Landing_screen_2 extends StatelessWidget {
//   const Landing_screen_2({super.key});
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
//                 'assets/L2.jpg',
//                 height: 300,
//                 width: 300,
//               ),
//               // const SizedBox(height: 10),
//               // Padding(
//               //   padding: const EdgeInsets.only(left: 100),
//               //   child: Image.asset('assets/bgimage3.jpeg',
//               //   height: 100,
//               //   width: 100,),
//               // ),
//               const Padding(
//                 padding: EdgeInsets.only(left: 25,right: 20),
//                 child: Text(
//                   'Buy or Rent Property',
//                   style: TextStyle(
//                       fontSize: 30,
//                       fontWeight: FontWeight.bold,
//                       color: AppColors.primary
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 10),
//               const Padding(
//                 padding: EdgeInsets.only(left: 30, right: 30),
//                 child: Text(
//                   'Explore a wide range of properties to buy or rent at your selected location.',
//                   style: TextStyle(
//                     fontSize: 16,
//                     color: AppColors.black,
//
//                   ),
//                 ),
//               ),
//               // const SizedBox(height: 10),
//               Spacer(),
//
//               const Padding(
//                 padding: EdgeInsets.only(left: 30, right: 30),
//                 child: Text(
//                   'Find your dream home with the best deals available.',
//                   style: TextStyle(
//                     fontSize: 16,
//                     color: AppColors.black87,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 10),
//               const Padding(
//                 padding: EdgeInsets.only(left: 30, right: 30),
//                 child: Text(
//                   'Get started now and connect with trusted sellers effortlessly.',
//                   style: TextStyle(
//                     fontSize: 16,
//                     color: AppColors.black87,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 50),
//
//               CustomButton(
//                 text: 'Get Started',
//                 isLoading: false,
//                 onPressed: () => Get.toNamed(AppRoutes.SplashScreen),
//                 width: 150,
//                 height: 45,
//                 backgroundColor: AppColors.primary,
//               ),
//
//
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


//////////////////////////////////

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app/configuration/ themes/app_colors.dart';
import '../../app/routes/app_routes.dart';
import '../../utils/Common_buttons&widgets/CustomButton.dart';
import '../../utils/size_config.dart';

class Landing_screen_2 extends StatelessWidget {
  const Landing_screen_2({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context); // Initialize responsive layout

    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/designed image.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
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
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: SizeConfig.imageSizeMultiplier * 90,
                      height: SizeConfig.imageSizeMultiplier * 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10,
                            offset: Offset(0, 6),
                          ),
                        ],
                        color: Colors.white,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: Image.asset(
                          'assets/L2.jpg',
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Text(
                      'buy_or_rent'.tr,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildInfoText('explore_properties'.tr),
                    _buildInfoText('find_home'.tr),
                    _buildInfoText('connect_sellers'.tr),
                    const SizedBox(height: 40),
                    CustomButton(
                      text: 'get_started'.tr,
                      isLoading: false,
                      onPressed: () => Get.toNamed(AppRoutes.SplashScreen),
                      width: SizeConfig.widthMultiplier * 40,
                      height: SizeConfig.heightMultiplier * 6,
                      borderRadius: 30,
                      backgroundColor: AppColors.primary,
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

