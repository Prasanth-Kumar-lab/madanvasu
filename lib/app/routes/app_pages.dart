
import 'package:flutter/material.dart';
import '../../Feature-based/MY_properties_list/my_property_list_screen.dart';
import '../../Feature-based/Reviews/All_Reviews_list/List_Review_binding.dart';
import '../../Feature-based/Reviews/All_Reviews_list/List_Review_widget.dart';
import '../../Feature-based/SavedProperties/saved_properties_binding.dart';
import '../../Feature-based/SavedProperties/saved_properties_controller.dart';
import '../../Feature-based/SavedProperties/svaed_properties_listscreen.dart';
import '../../Feature-based/home/FeaturedPoperties/featured_PropertiesController.dart';
import '../../Feature-based/home/FeaturedPoperties/featured_properties_widget.dart';
import '../../Feature-based/home/Sold_properties/sold_properties_screen.dart';
import '../../Feature-based/home/Sold_properties/sold_properties_widget.dart';
import '../../Feature-based/home/home/home_page.dart';
import '../../Feature-based/post_property_feature/post_property_screen.dart';
import 'app_imports.dart';


class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.decide,
      page: () => const DecideScreen(),
    ),
    GetPage(
      name: AppRoutes.landing,
      page: () => const Landing_screen_1(),
    ),

    GetPage(
      name: AppRoutes.landing2,
      page: () => const Landing_screen_2(),
    ),

    GetPage(
      name: AppRoutes.SplashScreen,
      page: () => const SplashScreen(),
    ),
    ////////////////////////////

    GetPage(
      name: AppRoutes.home,
      page: () => RealEstateHomeScreen(),
    ),
    GetPage(
      name: AppRoutes.register,
      page: () => RegistrationScreen(),
      binding: RegistrationBinding(),
    ),

    ////////////

    GetPage(
      name: AppRoutes.login,
      page: () => Login_Screen(toggleTheme: () {}),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.ForgetPassword,
      page: () => ForgetPasswordPage(),
      // binding: LoginBinding(),
    ),

    GetPage(
      name: AppRoutes.profile,
      page: () => ProfileDetails(),

      //const ProfileScreen(),

        binding: ProfileBinding()
    ),

    GetPage(
      name: AppRoutes.FeaturedProperties,
      page: () => PropertiesView(
        primaryColor: Get.arguments['primaryColor'],
        accentColor: Get.arguments['accentColor'],
        cardColor: Get.arguments['cardColor'],
        secondaryTextColor: Get.arguments['secondaryTextColor'],
      ),
      binding: PropertiesBinding(),
    ),


    GetPage(
      name: AppRoutes.AvailableProperties,
      page: () => AvailableProperties(
        primaryColor: Get.arguments['primaryColor'],
        accentColor: Get.arguments['accentColor'],
        cardColor: Get.arguments['cardColor'],
        secondaryTextColor: Get.arguments['secondaryTextColor'],
        // propertyStatusId: 2,
      ),
      binding: PropertiesBinding(),
    ),


    GetPage(
      name: AppRoutes.soldPropertyListScreen,
      page: () => SoldProperties(
        primaryColor: Get.arguments['primaryColor'],
        accentColor: Get.arguments['accentColor'],
        cardColor: Get.arguments['cardColor'],
        secondaryTextColor: Get.arguments['secondaryTextColor'],
        // propertyStatusId: 2,
      ),
      binding: PropertiesBinding(),
    ),



    GetPage(
      name: AppRoutes.My_Property_Screen,
      page: () => MyPropertyListScreen.fromArguments(),
    ),

    GetPage(
      name:AppRoutes.categories,
      page: () => const CategoryScreen(),
      binding: CategoryBinding(),
    ),

    // GetPage(
    //   name:AppRoutes.postproperties,
    //   page: () => const PostPropertyScreen(),
    //   // binding: CategoryBinding(),
    // ),

    GetPage(
      name: AppRoutes.savedproperties,
      page: () {
        final args = Get.arguments ?? {};
        return FavoritePropertiesScreen(
          primaryColor: args['primaryColor'] ?? Colors.orangeAccent,
          accentColor: args['accentColor'] ?? Colors.orange,
          cardColor: args['cardColor'] ?? Colors.white,
          secondaryTextColor: args['secondaryTextColor'] ?? Colors.grey,
        );
      },
      binding: FavoritePropertiesBinding(),
    ),

    // GetPage(
    //   name: AppRoutes.FeaturedProperties,
    //   page: () => FavoritePropertiesScreen(
    //     primaryColor: Get.arguments['primaryColor'],
    //     accentColor: Get.arguments['accentColor'],
    //     cardColor: Get.arguments['cardColor'],
    //     secondaryTextColor: Get.arguments['secondaryTextColor'],
    //   ),
    //   binding: BindingsBuilder(() {
    //     Get.lazyPut<PropertiesController>(() => PropertiesController());
    //     Get.lazyPut(() => FavoritePropertiesController(Get.find()));
    //   }),
    // ),


    GetPage(
      name:AppRoutes.ListReview_widget,
      page: () =>  PropertyReviewWidget(),
      binding: PropertyReviewBinding(),
    ),

    GetPage(
      name:AppRoutes.CreateProperty_Screen,
      page: () =>  CreateProperty_Screen(),
      // binding: PropertyReviewBinding(),
    ),
  ];
}
