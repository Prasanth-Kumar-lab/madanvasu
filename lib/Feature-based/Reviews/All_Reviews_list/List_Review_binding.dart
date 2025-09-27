import 'package:get/get.dart';

import 'List_Review_controller.dart';

class PropertyReviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PropertyReviewController>(() => PropertyReviewController());
  }
}
