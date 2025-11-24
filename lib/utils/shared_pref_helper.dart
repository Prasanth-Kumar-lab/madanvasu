import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper {

  static const List<String> userKeys = [
    'id',
    'personName',
    'email',
    'mobileNumber',
    'stateId',
    'districtId',
    'mandalId',
    'villageId',
    'locationId',
    'role',
    'profileImage',
    'branchId',
    'financialYearId',
    'stateName',
    'districtName',
    'mandalName',
    'villageName',
    'areaName',
  ];
  static const String _loggedInKey = 'isLoggedIn';
  static Future<void> saveUserData(Map<String, dynamic> userData) async {
    final prefs = await SharedPreferences.getInstance();
    for (var key in userKeys) {
      if (userData.containsKey(key)) {
        await prefs.setString(key, userData[key].toString());
      }
    }
  }


  static Future<void> setLoggedIn(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_loggedInKey, value);
  }


  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_loggedInKey) ?? false;
  }


  static Future<String?> getUserData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  static Future<void> clearUserData() async {
    final prefs = await SharedPreferences.getInstance();
    for (var key in userKeys) {
      await prefs.remove(key);
    }
    await prefs.remove(_loggedInKey);
  }
}
