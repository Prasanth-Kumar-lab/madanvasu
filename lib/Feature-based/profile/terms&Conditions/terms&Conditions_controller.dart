
import 'package:get/get.dart';
import '../../../data/Api_services/user_api_services.dart';

class TermsConditionsController extends GetxController {
  var isLoading = true.obs;
  var termsContent = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchTermsConditions();
  }

  Future<void> fetchTermsConditions() async {
    isLoading(true);
    try {
      final content = await ApiService.fetchTermsContent();
      termsContent.value = content;
    } finally {
      isLoading(false);
    }
  }
}
