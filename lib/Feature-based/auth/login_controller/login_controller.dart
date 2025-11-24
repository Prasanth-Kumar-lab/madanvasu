import 'package:get/get.dart';
import 'package:madhanvasu_app/Feature-based/auth/loging_model/login_model.dart';
import '../../../data/Api_services/user_api_services.dart';
import '../../../utils/shared_pref_helper.dart';

class LoginController extends GetxController {
  var isLoading = false.obs;

  void setLoading(bool value) {
    isLoading.value = value;
  }

  Future<bool> loginUser(String username, String password, String fcmToken) async {
    try {
      setLoading(true);

      LoginModel? loginModel = await ApiService.login(username, password, fcmToken);

      setLoading(false);

      if (loginModel != null && loginModel.status && loginModel.data.isNotEmpty) {
        Datum user = loginModel.data[0];

        await SharedPrefHelper.saveUserData({
          'id': user.id,
          'personName': user.personName,
          'email': user.email,
          'mobileNumber': user.mobileNumber,
          'role': user.role,
          'locationId': user.locationId,
          'profile_image': user.profileImage,
          'branchId': user.branchId,
          'financialYearId': user.financialYearId,
          'stateId': user.stateId,
          'districtId': user.districtId,
          'mandalId': user.mandalId,
          'villageId': user.villageId,

          'stateName': user.stateName,
          'districtName': user.districtName,
          'mandalName': user.mandalName,
          'villageName': user.villageName,
          'areaName': user.areaName,

        });

        await SharedPrefHelper.setLoggedIn(true);

        print('Login successful: User ${user.personName}');
        print('Login successful: User ${user.stateId}');
        print('Login successful: User ${user.districtId}');
        print('Login successful: User ${user.mandalId}');
        print('Login successful: User ${user.villageId}');


        return true;
      } else {
        print('Login failed: Invalid response or empty user data');
        return false;
      }
    } catch (e) {
      setLoading(false);
      print('Login error: $e');
      return false;
    }
  }
}
