
import 'package:get/get.dart';

import 'mandals_controller.dart';

class MandalBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MandalController>(() => MandalController());
  }
}
