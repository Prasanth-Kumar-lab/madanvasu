import 'package:get/get.dart';
import '../../../data/Api_services/user_api_services.dart';
import 'States_model.dart';

class StateController extends GetxController {
  var isLoading = false.obs;
  var statesList = <StatesModelData>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchStates();
  }

  Future<void> fetchStates() async {
    isLoading(true);
    try {
      final states = await ApiService.fetchStates();
      statesList.assignAll(states);
    } catch (e) {
      Get.snackbar("Error", "Failed to load states");
    } finally {
      isLoading(false);
    }
  }
}
