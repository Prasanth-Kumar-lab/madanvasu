import 'package:get/get.dart';

import 'dart:convert';
import '../../../data/Api_services/user_api_services.dart';
import 'FeaturedProperties_model.dart';


class PropertiesController extends GetxController {
  var isLoading = true.obs;

  var propertiesList = <PropertiesData>[].obs;
  var categoriesList = <PropertyCategory>[].obs;
  var statesList = <StateModel>[].obs;
  var districtsList = <District>[].obs;
  var mandalsList = <Mandal>[].obs;
  var villagesList = <Village>[].obs;


  final ApiService _repository = ApiService();


  @override
  void onInit() {
    fetchProperties();
    super.onInit();
  }

  // Future<void> fetchProperties() async {
  //   try {
  //     isLoading(true);
  //
  //     final wrapper = await _repository.PropertiesWrapper();
  //
  //     if (wrapper != null) {
  //       final reversedList = (wrapper.properties ?? []).reversed.toList();
  //       propertiesList.value = reversedList.take(20).toList();
  //
  //
  //       propertiesList.value = wrapper.properties ?? [];
  //       categoriesList.value = wrapper.propertiesCategories ?? [];
  //       statesList.value = wrapper.states ?? [];
  //       districtsList.value = wrapper.districts ?? [];
  //       mandalsList.value = wrapper.mandals ?? [];
  //       villagesList.value = wrapper.villages ?? [];
  //     }
  //   } catch (e) {
  //     Get.snackbar("Error", e.toString());
  //   } finally {
  //     isLoading(false);
  //   }
  // }


  Future<void> fetchProperties() async {
    try {
      isLoading(true);

      final wrapper = await _repository.PropertiesWrapper();

      if (wrapper != null) {
        final reversedList = (wrapper.properties ?? []).reversed.toList();
        propertiesList.value = reversedList.take(20).toList();

        categoriesList.value = wrapper.propertiesCategories ?? [];
        statesList.value = wrapper.states ?? [];
        districtsList.value = wrapper.districts ?? [];
        mandalsList.value = wrapper.mandals ?? [];
        villagesList.value = wrapper.villages ?? [];
      } else {
        print('Error: API returned null wrapper');
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading(false);
    }
  }

}