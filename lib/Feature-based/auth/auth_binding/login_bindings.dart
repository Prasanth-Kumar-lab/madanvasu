import 'package:get/get.dart';
import '../login_controller/login_controller.dart';
import '../registration/register_controller/registration_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController());
    // Get.lazyPut<RegistrationController>(() => RegistrationController());

  }

}
