
import 'package:get/get.dart';

import 'distric_controller.dart';

class DistrictBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DistrictController>(() => DistrictController());
  }
}
