import 'package:get/get.dart';
import '../../data/Api_services/user_api_services.dart';

class ContactController extends GetxController {
  var mobileNumber = ''.obs;
  var emailId = ''.obs;
  var address = ''.obs;
  var isLoading = false.obs;

  Future<void> fetchContactDetails() async {
    isLoading.value = true;

    final responseData = await ApiService.fetchContactDetails();

    if (responseData != null && responseData['status'] == true && responseData['data'] != null) {
      final data = responseData['data'][0];
      mobileNumber.value = data['mobile_number'] ?? '';
      emailId.value = data['email_id'] ?? '';
      address.value = data['address'] ?? '';
    } else {
      Get.snackbar('Error', 'Failed to load contact details');
    }

    isLoading.value = false;
  }
}
