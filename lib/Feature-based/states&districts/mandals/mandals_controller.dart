import 'package:get/get.dart';

import '../../../data/Api_services/user_api_services.dart';
import 'mandals_model.dart';

class MandalController extends GetxController {
  var isLoading = false.obs;
  var mandalList = <MandalData>[].obs;

  Future<void> fetchMandals({
    required String stateId,
    required String districtId,
  }) async {
    isLoading(true);

    try {
      final mandals = await ApiService.fetchMandals(stateId: stateId, districtId: districtId);
      mandalList.assignAll(mandals);
    } catch (e) {
      Get.snackbar("Error", "Your selected area was not in your range. Failed to load mandals");
    } finally {
      isLoading(false);
    }
  }

  void clearMandals() {
    mandalList.clear();
  }
}

