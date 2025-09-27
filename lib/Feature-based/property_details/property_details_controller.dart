import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'Property_details_model.dart';

class PropertyController extends GetxController {
  var isLoading = false.obs;
  var propertyDetailsModel = Rxn<PropertyDetailsModel>();
  var errorMessage = ''.obs;

  Future<void> fetchPropertyDetails(String propertyId) async {
    print(' Starting fetch for propertyId: $propertyId');  // Debug start
    isLoading.value = true;
    errorMessage.value = '';

    final String baseUrl = 'https://madanvasu.in/new/apis/Api_properties';
    final url = Uri.parse('$baseUrl/get_property_details?property_id=$propertyId');

    final Map<String, String> headers = {
      'Cookie': 'ci_session=5f0d9cfa80f508b281dd8f34a9666fe437af600d',
    };

    try {
      var request = http.Request('GET', url);
      request.headers.addAll(headers);

      final response = await request.send();

      print('Response status code: ${response.statusCode}'); // Debug status code

      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        print('Response body:\n$responseBody');  // Debug full response body

        final decodedJson = json.decode(responseBody);
        propertyDetailsModel.value = PropertyDetailsModel.fromJson(decodedJson);
      } else {
        print(' Error: ${response.reasonPhrase}');
        errorMessage.value = 'Error: ${response.reasonPhrase}';
        propertyDetailsModel.value = null;
      }
    } catch (e, stackTrace) {
      print(' Exception caught: $e');
      print('Stack trace:\n$stackTrace');
      errorMessage.value = 'Exception: $e';
      propertyDetailsModel.value = null;
    } finally {
      isLoading.value = false;
      print('Fetch finished, isLoading = false');
    }
  }
}
