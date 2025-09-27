import 'package:get/get.dart';

import 'LocationController.dart';

class LocationBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(LocationController());
  }
}