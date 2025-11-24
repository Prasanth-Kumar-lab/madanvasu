import 'package:get/get.dart';
import 'package:madhanvasu_app/Feature-based/states&districts/villages/villages_model.dart';

import '../../../data/Api_services/user_api_services.dart';

class VillageController extends GetxController {
  var isLoading = false.obs;
  var villageList = <VillageData>[].obs;

  Future<void> fetchVillages({
    required String stateId,
    required String districtId,
    required String mandalId,
  }) async {
    isLoading(true);
    try {
      final villages = await ApiService.fetchVillages(
        stateId: stateId,
        districtId: districtId,
        mandalId: mandalId,
      );
      villageList.assignAll(villages);
    } catch (e) {
      Get.snackbar("Error", "Failed to load villages");
    } finally {
      isLoading(false);
    }
  }

  void clearVillages() {
    villageList.clear();
  }
}
