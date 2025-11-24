
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:madhanvasu_app/data/Api_services/user_api_services.dart';

import '../../../states&districts/districts/distric_controller.dart';
import '../../../states&districts/districts/districts_model.dart';
import '../../../states&districts/mandals/mandals_controller.dart';
import '../../../states&districts/mandals/mandals_model.dart';
import '../../../states&districts/states/States_model.dart';
import '../../../states&districts/states/states_controller.dart';
import '../../../states&districts/villages/villages_controller.dart';
import '../../../states&districts/villages/villages_model.dart';
import '../../login_view/loginScreen.dart';

class RegistrationController extends GetxController {
  final name = ''.obs;
  final email = ''.obs;
  final phone = ''.obs;
  final password = ''.obs;
  final confirmPassword = ''.obs;

  final obscurePassword = true.obs;
  final obscureConfirm = true.obs;
  final agreed = false.obs;

  final formKey = GlobalKey<FormState>();

  final stateController = Get.put(StateController());
  final districtController = Get.put(DistrictController());
  final MandalController mandalController = Get.put(MandalController());
  final VillageController villageController = Get.put(VillageController());

  final selectedState = Rxn<StatesModelData>();
  final selectedDistrict = Rxn<DistrictData>();
  var selectedMandal = Rx<MandalData?>(null);

  var selectedVillage = Rx<VillageData?>(null);



  @override
  void onInit() {
    super.onInit();
    stateController.fetchStates();
  }

  void togglepassword() => obscurePassword.toggle();
  void toggleConfirm() => obscureConfirm.toggle();
  void toggleAgree(bool? v) => agreed.value = v ?? false;


  Future<void> register() async {
    if (!agreed.value) {
      Get.snackbar(
        'Error',
        'You must agree to the Terms & Conditions',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (!formKey.currentState!.validate()) return;

    final result = await ApiService.registerUser(
      name: name.value.trim(),
      email: email.value.trim(),
      phone: phone.value.trim(),
      password: password.value.trim(),
      stateId: selectedState.value!.id,
      districtId: selectedDistrict.value!.id,
      mandalId: selectedMandal.value!.id,
      villageId: selectedVillage.value!.id,
    );

    if (result['status']) {
      Get.snackbar(
        'Success',
        'Registration successful! Please login.',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      Get.offAll(() => Login_Screen(toggleTheme: () {}));
    } else {
      Get.snackbar(
        'Error',
        result['message'] ?? 'Registration failed! Please try again.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }


}
