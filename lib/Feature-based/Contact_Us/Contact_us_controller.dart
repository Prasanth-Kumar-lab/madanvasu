import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ContactController extends GetxController {
  var mobileNumber = ''.obs;
  var emailId = ''.obs;
  var address = ''.obs;
  var isLoading = false.obs;

  Future<void> fetchContactDetails() async {
    isLoading.value = true;

    var headers = {
      'Cookie': 'ci_session=f985237c86535f1740b72b4b830249eb1991839d'
    };

    var url = Uri.parse('https://madanvasu.in/new/apis/Api_contactus/getcontactus');

    var request = http.Request('GET', url);
    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        final responseData = json.decode(await response.stream.bytesToString());

        if (responseData['status'] == true && responseData['data'] != null) {
          final data = responseData['data'][0];
          mobileNumber.value = data['mobile_number'];
          emailId.value = data['email_id'];
          address.value = data['address'];
        } else {
          Get.snackbar('Error', 'No data found');
        }
      } else {
        Get.snackbar('Error', 'Failed to load contact details');
      }
    } catch (e) {
      Get.snackbar('Exception', e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}