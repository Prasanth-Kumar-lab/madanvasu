import 'package:get/get.dart';
import '../../../data/Api_services/user_api_services.dart';

class PrivacyPolicyController extends GetxController {
  var isLoading = true.obs;
  var policyContent = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchPrivacyPolicy();
  }

  Future<void> fetchPrivacyPolicy() async {
    isLoading(true);
    try {
      final content = await ApiService.fetchPrivacyPolicyContent();
      policyContent.value = content;
    } finally {
      isLoading(false);
    }
  }
}
