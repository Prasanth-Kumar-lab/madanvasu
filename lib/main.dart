// import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'Feature-based/Landing_screens/landing_screen1.dart';
// import 'madhanvasu_lib/aswini_screens/home_page.dart';
//
// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       title: 'Madhanvasu App',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//       ),
//       home: const DecideScreen(),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }
//
// class DecideScreen extends StatefulWidget {
//   const DecideScreen({super.key});
//
//   @override
//   State<DecideScreen> createState() => _DecideScreenState();
// }
//
// class _DecideScreenState extends State<DecideScreen> {
//   bool? isLoggedIn;
//
//   @override
//   void initState() {
//     super.initState();
//     _checkLoginStatus();
//   }
//
//   Future<void> _checkLoginStatus() async {
//     final prefs = await SharedPreferences.getInstance();
//     bool loggedIn = prefs.getBool('isLoggedIn') ?? false;
//
//     setState(() {
//       isLoggedIn = loggedIn;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if (isLoggedIn == null) {
//       return const Center(
//         child: CupertinoActivityIndicator(radius: 15),
//       );
//     } else if (isLoggedIn == true) {
//       return RealEstateHomeScreen();
//     } else {
//       return const Landing_screen_1();
//     }
//   }
// }


///////////////
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'Feature-based/Landing_screens/landing_screen1.dart';
import 'Feature-based/app_Language/app_translations.dart';
import 'Feature-based/splash_screen/splashscreen.dart';
import 'app/configuration/themes/app_colors.dart';
import 'app/routes/app_pages.dart';
import 'app/routes/app_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Feature-based/home/home/home_page.dart';
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Background message received: ${message.messageId}');
}


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await _initializeFCM();

  runApp(const MyApp());
}


Future<void> _initializeFCM() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized ||
      settings.authorizationStatus == AuthorizationStatus.provisional) {
    String? token = await messaging.getToken();
    print('FCM Token: $token');
  } else {
    print('Notification permission not granted');
  }

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print(' Foreground message: ${message.notification?.title}');
    if (message.notification != null) {
      Get.snackbar(
        message.notification!.title ?? "Notification",
        message.notification!.body ?? "",
        snackPosition: SnackPosition.TOP,
        backgroundColor: AppColors.secondary,
        colorText: Colors.black,
      );
    }
  });

  // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
  //   print(' Notification tapped (app resumed): ${message.notification?.title}');
  //   // Add navigation logic here if needed
  // });
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

      ControllerHelper.initializeControllers();

    return GetMaterialApp(

      title: 'Madanvasu App',
      translations: AppTranslations(),
      locale: const Locale('en', 'US'),
      fallbackLocale: const Locale('en', 'US'), ///////////////
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.decide,
      getPages: AppPages.pages,
    );
  }
}


class DecideScreen extends StatefulWidget {
  const DecideScreen({super.key});

  @override
  State<DecideScreen> createState() => _DecideScreenState();
}

class _DecideScreenState extends State<DecideScreen> {
  bool? isLoggedIn;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    bool loggedIn = prefs.getBool('isLoggedIn') ?? false;

    setState(() {
      isLoggedIn = loggedIn;
    });
  }

  Future<bool> _onWillPop() async {
    return await Get.dialog(
      AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        title: Row(
          children: [
            Icon(Icons.exit_to_app, color: AppColors.primary),
            const SizedBox(width: 10),
            const Text(
              'Exit App',
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
        content: const Text(
          'Do you really want to exit the app?',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 16,
          ),
        ),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.grey.shade200,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () => Get.back(result: false),
            child: const Text(
              'No',
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () => Get.back(result: true),
            child: const Text(
              'Yes',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    ) ?? false;
  }

  @override
  Widget build(BuildContext context) {
    if (isLoggedIn == null) {
      return const Center(
        child: CupertinoActivityIndicator(radius: 15),
      );
    } else if (isLoggedIn == true) {
      return WillPopScope(
        onWillPop: _onWillPop,
        child:SplashScreen(),
        //RealEstateHomeScreen(),
      );
    } else {
      return WillPopScope(
        onWillPop: _onWillPop,
        child: const Landing_screen_1(),
      );
    }
  }
}

