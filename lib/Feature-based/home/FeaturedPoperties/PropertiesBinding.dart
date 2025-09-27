import 'package:get/get.dart';

import 'featured_PropertiesController.dart';

class PropertiesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PropertiesController>(() => PropertiesController());


  }
}
