// lib/controllers/district_controller.dart

import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'districts_model.dart';

class DistrictController extends GetxController {
  var isLoading = false.obs;
  var districtList = <DistrictData>[].obs;

  /// Fetch districts based on selected state ID
  Future<void> fetchDistricts(String stateId) async {
    isLoading(true);

    var headers = {
      'Cookie': 'ci_session=a04f1896c10dbdf35a7324eddc717f4c12e8fa4b'
    };

    var request = http.Request(
      'GET',
      Uri.parse(
          'https://madanvasu.in/new/apis/Api_districts/get_districts?state_id=$stateId'),
    );

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var jsonString = await response.stream.bytesToString();
      var jsonData = json.decode(jsonString);

      DistrictNameModel model = DistrictNameModel.fromJson(jsonData);
      districtList.assignAll(model.data);
    } else {
      Get.snackbar("Error", "Failed to load districts");
    }

    isLoading(false);
  }

  /// Clear the district list
  void clearDistricts() {
    districtList.clear();
  }
}
