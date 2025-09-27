import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CustomerPlanController extends GetxController {
  var isLoading = false.obs;

  Future<void> submitCustomerPlan({
    required String propertyId,
    required String userId,
    required String planDaysId,
  }) async {
    isLoading.value = true;

    var headers = {
      'Cookie': 'ci_session=e120d6fb08532656fd24e7710ac5fda3238b2754',
    };

    var request = http.MultipartRequest(
      'POST',
      Uri.parse('https://madanvasu.in/new/apis/Api_property_plan/customer_property_plan'),
    );

    request.fields.addAll({
      'property_id': propertyId,
      'user_id': userId,
      'plan_days_id': planDaysId,
      'active': 'Active'
    });

    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        Get.snackbar("Success", "Plan submitted successfully!");
        print(responseData); // Optionally parse and use the response
      } else {
        Get.snackbar("Error", "Status Code: ${response.statusCode}");
        print(response.reasonPhrase);
      }
    } catch (e) {
      Get.snackbar("Exception", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
