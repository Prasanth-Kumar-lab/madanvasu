import 'package:get/get.dart';
import 'package:madhanvasu_app/Feature-based/property_status/propertys_status_model.dart';

import '../../data/Api_services/user_api_services.dart';

class PropertyStatusController extends GetxController {
  var isLoading = false.obs;
  var propertyStatusList = <PropertyStatusData>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchPropertyStatuses();
  }

  Future<void> fetchPropertyStatuses() async {
    isLoading(true);

    try {
      final data = await ApiService.fetchPropertyStatuses();
      propertyStatusList.value = data;
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }
}
