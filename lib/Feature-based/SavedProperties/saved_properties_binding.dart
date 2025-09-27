// import 'package:get/get.dart';
// import 'package:madhanvasu_app/Feature-based/SavedProperties/saved_properties_controller.dart';
//
// import '../../data/Api_services/user_api_services.dart';
//
// class FavoritePropertiesBinding extends Bindings {
//   @override
//   void dependencies() {
//     Get.lazyPut(() => ApiService());
//     Get.lazyPut(() => FavoritePropertiesController(Get.find()));
//   }
// }


import 'package:get/get.dart';
import 'package:madhanvasu_app/Feature-based/SavedProperties/saved_properties_controller.dart';
import '../../data/Api_services/user_api_services.dart';

class FavoritePropertiesBinding extends Bindings {
  @override
  void dependencies() {
    // Register ApiService as a singleton if not already registered
    if (!Get.isRegistered<ApiService>()) {
      Get.put(ApiService(), permanent: true);
    }

    // Register FavoritePropertiesController as a singleton to maintain state
    if (!Get.isRegistered<FavoritePropertiesController>()) {
      Get.put(FavoritePropertiesController(Get.find<ApiService>()), permanent: true);
    }
  }
}