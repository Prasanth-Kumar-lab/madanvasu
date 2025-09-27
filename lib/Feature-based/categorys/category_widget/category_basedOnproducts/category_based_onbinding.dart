import 'package:get/get.dart';

import 'category_basedon_controller.dart';


class PropertiesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CategoryBasedonController>(() => CategoryBasedonController());


  }
}
