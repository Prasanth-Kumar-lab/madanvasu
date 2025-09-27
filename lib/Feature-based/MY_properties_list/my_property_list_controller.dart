import 'package:get/get.dart';
import '../../data/Api_services/user_api_services.dart';
import 'my_properties_list_model.dart';

class MyPropertyListController extends GetxController {
  final ApiService _apiRepository = ApiService();

  final RxBool isLoading = false.obs;
  final RxList<Properties> properties = <Properties>[].obs;
  final RxString errorMessage = ''.obs;

  String? userId;

  MyPropertyListController([this.userId]);

  void updateUserId(String id) {
    userId = id;
  }

  Future<void> fetchProperties() async {
    if (userId == null || userId!.isEmpty) {
      errorMessage.value = 'User ID not set.';
      return;
    }

    try {
      isLoading.value = true;
      errorMessage.value = '';

      print(" Fetching properties for userId: $userId");

      final response = await _apiRepository.fetchProperties(userId!);

      print(" API Response Status: ${response.status}");
      print(" API Response Data: ${response.data}");

      if (response.status && response.data != null) {
        properties.assignAll(response.data!.properties);
        print(" Properties loaded: ${properties.length}");
      } else {
        errorMessage.value = 'No properties found.';
        print("⚠ No properties found or invalid data.");
      }
    } catch (e, stacktrace) {
      errorMessage.value = 'Failed to load properties.';
      print(" Error fetching properties: $e");
      print(" Stacktrace: $stacktrace");
    } finally {
      isLoading.value = false;
    }
  }
}
