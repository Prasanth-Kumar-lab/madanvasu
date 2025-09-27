// lib/controllers/mandal_controller.dart

import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'mandals_model.dart';

class MandalController extends GetxController {
  var isLoading = false.obs;
  var mandalList = <MandalData>[].obs;

  Future<void> fetchMandals({
    required String stateId,
    required String districtId,
  }) async {
    isLoading(true);

    var headers = {
      'Cookie': 'ci_session=152b862654e76b26067650896768ba8b7d5d7afe',
    };

    var request = http.Request(
      'GET',
      Uri.parse('https://madanvasu.in/new/apis/Api_mandals/get_mandals?state_id=$stateId&district_id=$districtId'),
    );

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var responseBody = await response.stream.bytesToString();
      var jsonData = json.decode(responseBody);

      MandalNameModel model = MandalNameModel.fromJson(jsonData);
      mandalList.assignAll(model.data);
    } else {
      Get.snackbar("Error", " Your selected area was not in your range . Failed to load mandals");
    }

    isLoading(false);
  }

  void clearMandals() {
    mandalList.clear();
  }

}
