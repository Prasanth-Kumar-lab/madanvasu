// lib/controllers/village_controller.dart

import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:madhanvasu_app/Feature-based/states&districts/villages/villages_model.dart';

class VillageController extends GetxController {
  var isLoading = false.obs;
  var villageList = <VillageData>[].obs;

  Future<void> fetchVillages({
    required String stateId,
    required String districtId,
    required String mandalId,
  }) async {
    isLoading(true);

    var headers = {
      'Cookie': 'ci_session=152b862654e76b26067650896768ba8b7d5d7afe',
    };

    var request = http.Request(
      'GET',
      Uri.parse(
        'https://madanvasu.in/new/apis/Api_villages/get_villages?state_id=$stateId&district_id=$districtId&mandal_id=$mandalId',
      ),
    );

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var responseBody = await response.stream.bytesToString();
      var jsonData = json.decode(responseBody);

      VillageModel model = VillageModel.fromJson(jsonData);
      villageList.assignAll(model.data);
    } else {
      Get.snackbar("Error", "Failed to load villages");
    }

    isLoading(false);
  }

  void clearVillages() {
    villageList.clear();
  }

}
