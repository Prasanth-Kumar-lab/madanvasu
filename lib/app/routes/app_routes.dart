import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:madhanvasu_app/Feature-based/home/Available_properties/Available_properties_widget.dart';
import 'package:madhanvasu_app/Feature-based/home/Sold_properties/sold_properties_screen.dart';

import '../../Feature-based/SavedProperties/saved_properties_controller.dart';
import '../../data/Api_services/user_api_services.dart';


class ControllerHelper {
  static void initializeControllers() {
    try {
      // Initialize ApiService if not already registered
      if (!Get.isRegistered<ApiService>()) {
        Get.put(ApiService(), permanent: true);
      }

      // Initialize FavoritePropertiesController if not already registered
      if (!Get.isRegistered<FavoritePropertiesController>()) {
        Get.put(
          FavoritePropertiesController(Get.find<ApiService>()),
          permanent: true,
        );
      }
    } catch (e) {
      print('Error initializing controllers: $e');
      // Fallback initialization
      try {
        Get.put(ApiService(), permanent: true);
        Get.put(
          FavoritePropertiesController(ApiService()),
          permanent: true,
        );
      } catch (fallbackError) {
        print('Fallback initialization also failed: $fallbackError');
      }
    }
  }

  static FavoritePropertiesController? getFavoriteController() {
    try {
      return Get.find<FavoritePropertiesController>();
    } catch (e) {
      print('Controller not found: $e');
      return null;
    }
  }
}

/////////////

abstract class AppRoutes {
  static const decide = '/';
  static const home = '/home';
  static const landing = '/landing';
  static const landing2 = '/Landing_screen_2';
  static const SplashScreen = '/SplashScreen';

  static const register = '/register';
  static const ForgetPassword = '/ForgetPassword';
  static const login = '/login';

  static const profile = '/profile';
  static const categories = '/categories';

  static const FeaturedProperties = '/FeaturedPropertiesList';

  static const AvailableProperties = '/AvailablePropertiesList';
  static const soldPropertyListScreen = '/soldPropertyListScreen';



  static const postproperties = '/postproperties';

  static const savedproperties = '/savedproperties';

  static const ListReview_widget = '/ListReview';

  static const CreateProperty_Screen = '/CreateProperty_Screen_List';


  static const My_Property_Screen = '/MyPropertyListScreen';


}
