import 'package:get/get.dart';

import '../../../data/Api_services/user_api_services.dart';
import 'districts_model.dart';

class DistrictController extends GetxController {
  var isLoading = false.obs;
  var districtList = <DistrictData>[].obs;

  Future<void> fetchDistricts(String stateId) async {
    isLoading(true);

    try {
      final districts = await ApiService.fetchDistricts(stateId);
      districtList.assignAll(districts);
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading(false);
    }
  }

  void clearDistricts() {
    districtList.clear();
  }
}
