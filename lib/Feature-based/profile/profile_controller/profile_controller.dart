import 'package:get/get.dart';
// import '../../../app/utils/shared_pref_helper.dart';
import '../../../utils/shared_pref_helper.dart';

class ProfileController extends GetxController {
  var name = ''.obs;
  var email = ''.obs;
  var phone = ''.obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    try {
      isLoading(true);
      final Map<String, String> userData = {};
      for (var key in SharedPrefHelper.userKeys) {
        final value = await SharedPrefHelper.getUserData(key);
        userData[key] = value ?? '';
      }

      name.value = userData['personName'] ?? 'Guest';
      email.value = userData['email'] ?? 'No email available';
      phone.value = userData['mobileNumber'] ?? 'No phone number available';
    } finally {
      isLoading(false);
    }
  }

  void logout() {
    SharedPrefHelper.clearUserData();
    Get.offAllNamed('/login');
  }
}
