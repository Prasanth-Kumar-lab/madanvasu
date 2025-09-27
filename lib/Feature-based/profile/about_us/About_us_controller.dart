import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AboutUsController extends GetxController {
  var isLoading = true.obs;
  var aboutTitle = ''.obs;
  var aboutDescription = ''.obs;
  var aboutImage = ''.obs;

  @override
  void onInit(){
    super.onInit();
    fetchAboutUs();
  }

  Future<void> fetchAboutUs() async {
    try {
      isLoading(true);
      var headers = {
        'Cookie': 'ci_session=f985237c86535f1740b72b4b830249eb1991839d'
      };
      var request = http.Request('GET',
          Uri.parse('https://madanvasu.in/new/apis/Api_aboutus/getaboutus'));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        final data = jsonDecode(responseBody);

        if (data['status'] == true && data['data'].isNotEmpty) {
          aboutTitle.value = data['data'][0]['about_title'];
          aboutDescription.value = data['data'][0]['about_desc'];
          aboutImage.value = data['data'][0]['about_image'];
        } else {
          aboutDescription.value = 'No about us data available';
        }
      } else {
        aboutDescription.value = 'Failed: ${response.reasonPhrase}';
      }
    } catch (e) {
      aboutDescription.value = 'Error: $e';
    } finally {
      isLoading(false);
    }
  }
}

