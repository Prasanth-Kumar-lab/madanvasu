// lib/controllers/state_controller.dart

import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'States_model.dart';

class StateController extends GetxController {
  var isLoading = false.obs;
  var statesList = <StatesModelData>[].obs;

  @override
  void onInit() {
    fetchStates();
    super.onInit();
  }

  Future<void> fetchStates() async {
    isLoading(true);
    var headers = {
      'Cookie': 'ci_session=ecdd8d906ff24a14ffc12b0d67bf467ff6be4376'
    };

    var request = http.Request(
      'GET',
      Uri.parse('https://madanvasu.in/new/apis/Api_states/get_states'),
    );
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var jsonString = await response.stream.bytesToString();
      var jsonData = json.decode(jsonString);

      StatesModel model = StatesModel.fromJson(jsonData);
      statesList.assignAll(model.data);
    } else {
      Get.snackbar("Error", "Failed to load states");
    }

    isLoading(false);
  }
}
