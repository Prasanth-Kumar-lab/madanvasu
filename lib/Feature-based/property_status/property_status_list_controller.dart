import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:madhanvasu_app/Feature-based/property_status/propertys_status_model.dart';

class PropertyStatusController extends GetxController {
  var isLoading = false.obs;
  var propertyStatusList = <PropertyStatusData>[].obs;

  final String sessionCookie = 'ci_session=83e2a8e600d5489f97e329ea70d52b4b17216e7f';

  @override
  void onInit() {
    super.onInit();
    fetchPropertyStatuses();
  }

  Future<void> fetchPropertyStatuses() async {
    isLoading(true);
    final headers = {
      'Cookie': sessionCookie,
    };

    final request = http.Request(
      'GET',
      Uri.parse('https://madanvasu.in/new/apis/Api_add_property_status/property_status_list'),
    );
    request.headers.addAll(headers);

    try {
      final response = await request.send();

      if (response.statusCode == 200) {
        final body = await response.stream.bytesToString();
        final decoded = json.decode(body);
        final propertyStatus = PropertyStatus.fromJson(decoded);

        propertyStatusList.value = propertyStatus.data;
      } else {
        Get.snackbar('Error', 'Status Code: ${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar('Error', 'Exception: $e');
    } finally {
      isLoading(false);
    }
  }
}
