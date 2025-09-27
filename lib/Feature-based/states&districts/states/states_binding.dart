
import 'package:get/get.dart';
import 'package:madhanvasu_app/Feature-based/states&districts/states/states_controller.dart';

class StateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StateController>(() => StateController());
  }
}
