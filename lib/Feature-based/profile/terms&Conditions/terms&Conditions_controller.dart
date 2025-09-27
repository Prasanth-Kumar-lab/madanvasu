import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TermsConditionsController extends GetxController {
  var isLoading = true.obs;
  var termsContent = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchTermsConditions();
  }

  Future<void> fetchTermsConditions() async {
    try {
      isLoading(true);

      var headers = {
        'Cookie': 'ci_session=f62dd2de6712e6747ffbd7c6b1d211a5aa82677c'
      };

      var request = http.Request(
        'GET',
        Uri.parse('https://madanvasu.in/new/apis/Api_terms_conditions/gettermsconditions'),
      );

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        final decoded = jsonDecode(responseBody);

        if (decoded['status'] == true && decoded['data'].isNotEmpty) {
          termsContent.value = decoded['data'][0]['content_description'];
        } else {
          termsContent.value = 'No terms & conditions available.';
        }
      } else {
        termsContent.value = 'Failed to fetch terms: ${response.reasonPhrase}';
      }
    } catch (e) {
      termsContent.value = 'Error: $e';
    } finally {
      isLoading(false);
    }
  }
}
