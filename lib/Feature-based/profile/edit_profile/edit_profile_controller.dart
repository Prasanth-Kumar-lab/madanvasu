// import 'dart:convert';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:madhanvasu_app/utils/shared_pref_helper.dart';
//
// class EditProfileController extends GetxController {
//   var isUpdating = false.obs;
//
//   final personName = ''.obs;
//   final mobileNumber = ''.obs;
//   final email = ''.obs;
//   final username = ''.obs;
//   final password = ''.obs;
//   final address = ''.obs;
//
//   Future<void> updateProfile() async {
//     try {
//       isUpdating(true);
//
//       String? userId = await SharedPrefHelper.getUserData("id");
//
//
//       var request = http.MultipartRequest(
//         'POST',
//         Uri.parse('https://madanvasu.in/new/apis/Api_profile_edit/update_user_details'),
//       );
//
//       request.fields.addAll({
//         'user_id': userId ?? '',
//         'person_name': personName.value,
//         'mobile_number': mobileNumber.value,
//         'email': email.value,
//         'username': username.value,
//         'password': password.value,
//         'address': address.value,
//       });
//
//       request.headers.addAll({
//         'Cookie': 'ci_session=1c7a1ac6e9d64e7de9b7792e526959fb6f1ca666',
//       });
//
//       http.StreamedResponse response = await request.send();
//
//       if (response.statusCode == 200) {
//         final respStr = await response.stream.bytesToString();
//         final jsonResp = jsonDecode(respStr);
//         print("API Response: $jsonResp");
//
//         if (jsonResp['status'] == true) {
//           Get.snackbar('Success', 'Applied changes successfully');
//           Get.back(result: true);
//
//
//           await SharedPrefHelper.saveUserData({
//             'personName': personName.value,
//             'mobileNumber': mobileNumber.value,
//             'email': email.value,
//             'username': username.value,
//             'password': password.value,
//             'address': address.value,
//           });
//
//
//           await Future.delayed(const Duration(seconds: 3));
//           print("Navigating back to ProfileScreen...");
//           Get.back(result: true);
//         }
//
//         else {
//           Get.snackbar('Error', jsonResp['message']);
//         }
//       } else {
//         Get.snackbar('Error', 'Server error: ${response.reasonPhrase}');
//       }
//     } catch (e) {
//       Get.snackbar('Error', 'Something went wrong: $e');
//     } finally {
//       isUpdating(false);
//     }
//   }
//
//   void loadInitialData(Map<String, String> userData) {
//     personName.value = userData['personName'] ?? '';
//     mobileNumber.value = userData['mobileNumber'] ?? '';
//     email.value = userData['email'] ?? '';
//     username.value = userData['username'] ?? '';
//     password.value = userData['password'] ?? '';
//     address.value = userData['address'] ?? '';
//   }
// }



import 'package:get/get.dart';
import 'package:madhanvasu_app/utils/shared_pref_helper.dart';
import '../../../data/Api_services/user_api_services.dart';

class EditProfileController extends GetxController {
  var isUpdating = false.obs;
  var isPasswordVisible = false.obs;

  final personName = ''.obs;
  final mobileNumber = ''.obs;
  final email = ''.obs;
  final username = ''.obs;
  final password = ''.obs;
  final address = ''.obs;

  final passwordError = ''.obs;

  void loadInitialData(Map<String, String> userData) {
    personName.value = userData['personName'] ?? '';
    mobileNumber.value = userData['mobileNumber'] ?? '';
    email.value = userData['email'] ?? '';
    username.value = userData['username'] ?? '';
    password.value = userData['password'] ?? '';
    address.value = userData['address'] ?? '';
  }

  Future<void> updateProfile() async {
    passwordError.value = '';

    if (!isValidPassword(password.value)) {
      passwordError.value = "Password must be at least 6 characters.";
      return;
    }

    isUpdating(true);

    try {
      String? userId = await SharedPrefHelper.getUserData("id");

      final data = {
        'user_id': userId ?? '',
        'person_name': personName.value,
        'mobile_number': mobileNumber.value,
        'email': email.value,
        'username': username.value,
        'password': password.value,
        'address': address.value,
      };

      final response = await ApiService.updateUserProfile(data);

      if (response != null && response['status'] == true) {
        Get.snackbar('Success', 'Profile updated successfully');

        await SharedPrefHelper.saveUserData({
          'personName': personName.value,
          'mobileNumber': mobileNumber.value,
          'email': email.value,
          'username': username.value,
          'password': password.value,
          'address': address.value,
        });

        await Future.delayed(const Duration(seconds: 2));
        Get.back(result: true);
      } else {
        Get.snackbar('Error', response?['message'] ?? 'Something went wrong');
      }
    } catch (e) {
      Get.snackbar('Error', 'Exception: $e');
    } finally {
      isUpdating(false);
    }
  }

  bool isValidPassword(String value) {
    return value.length >= 6;
  }
}
