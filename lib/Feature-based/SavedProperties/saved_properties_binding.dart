import 'package:get/get.dart';
import 'package:madhanvasu_app/Feature-based/SavedProperties/saved_properties_controller.dart';
import '../../data/Api_services/user_api_services.dart';

class FavoritePropertiesBinding extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<ApiService>()) {
      Get.put(ApiService(), permanent: true);
    }

    if (!Get.isRegistered<FavoritePropertiesController>()) {
      Get.put(FavoritePropertiesController(Get.find<ApiService>()), permanent: true);
    }
  }
}