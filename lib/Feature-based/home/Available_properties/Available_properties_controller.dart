
import 'package:get/get.dart';
import '../../../data/Api_services/user_api_services.dart';
import '../FeaturedPoperties/FeaturedProperties_model.dart';

class Available_PropertiesController extends GetxController {
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
  //     final wrapper = await _repository.Available_PropertiesWrapper();
  //
  //     if (wrapper != null) {
  //       propertiesList.value = wrapper.properties ?? [];
  //       categoriesList.value = wrapper.propertiesCategories ?? [];
  //       statesList.value = wrapper.states ?? [];
  //       districtsList.value = wrapper.districts ?? [];
  //       mandalsList.value = wrapper.mandals ?? [];
  //       villagesList.value = wrapper.villages ?? [];
  //
  //       print('Fetched Properties Count: ${propertiesList.length}');
  //       print('Fetched Villages Count: ${villagesList.length}');
  //       print('Properties Data:');
  //       for (var property in propertiesList) {
  //         print(
  //             'Property ID: ${property.id}, Title: ${property.title}, Village ID: ${property.villageId}, Village ID Type: ${property.villageId.runtimeType}');
  //       }
  //       print('Villages Data:');
  //       for (var village in villagesList) {
  //         print('Village ID: ${village.id}, Village Name: ${village.name}, Village ID Type: ${village.id.runtimeType}');
  //       }
  //     } else {
  //       print('Error: API returned null wrapper');
  //     }
  //   } catch (e) {
  //     print('Error in fetchProperties: $e');
  //     Get.snackbar("Error", e.toString());
  //   } finally {
  //     isLoading(false);
  //   }
  // }

  Future<void> fetchProperties() async {
    try {
      isLoading(true);

      final wrapper = await _repository.Available_PropertiesWrapper();

      if (wrapper != null) {
        final reversedList = (wrapper.properties ?? []).reversed.toList();
        propertiesList.value = reversedList.take(20).toList();

        categoriesList.value = wrapper.propertiesCategories ?? [];
        statesList.value = wrapper.states ?? [];
        districtsList.value = wrapper.districts ?? [];
        mandalsList.value = wrapper.mandals ?? [];
        villagesList.value = wrapper.villages ?? [];

        print('Fetched (limited) Properties Count: ${propertiesList.length}');
        for (var property in propertiesList) {
          print(
              'Property ID: ${property.id}, Title: ${property.title}, Village ID: ${property.villageId}');
        }
      } else {
        print('Error: API returned null wrapper');
      }
    } catch (e) {
      print('Error in fetchProperties: $e');
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading(false);
    }
  }


}
