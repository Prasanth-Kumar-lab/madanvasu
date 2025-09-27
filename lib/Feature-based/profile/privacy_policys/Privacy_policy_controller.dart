import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class PrivacyPolicyController extends GetxController {
  var isLoading = true.obs;
  var policyContent = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchPrivacyPolicy();
  }

  Future<void> fetchPrivacyPolicy() async {
    try {
      isLoading(true);

      var headers = {
        'Cookie': 'ci_session=14b22b25b4ec49d03cbaafdf8d607d7f56ee90de'
      };

      var request = http.Request('GET', Uri.parse('https://madanvasu.in/new/apis/Api_privacy_policy/getprivacypolicy'));
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        final decoded = jsonDecode(responseBody);
        if (decoded['status'] == true && decoded['data'].isNotEmpty) {
          policyContent.value = decoded['data'][0]['content_description'];
        } else {
          policyContent.value = 'No privacy policy available.';
        }
      } else {
        policyContent.value = 'Failed to fetch Policy: ${response.reasonPhrase}';
      }
    } catch (e) {
      policyContent.value = 'Error: $e';
    } finally {
      isLoading(false);
    }
  }
}
