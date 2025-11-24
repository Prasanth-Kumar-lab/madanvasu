
import 'package:get/get.dart';
import 'package:madhanvasu_app/Feature-based/states&districts/villages/villages_controller.dart';

class VillageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VillageController>(() => VillageController());
  }
}
