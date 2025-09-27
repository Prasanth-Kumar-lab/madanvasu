// import 'dart:convert';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
//
// import 'FeaturedProperties_model.dart';
//
// class PropertiesController extends GetxController {
//   var isLoading = true.obs;
//   var propertiesList = <PropertiesData>[].obs;
//
//   @override
//   void onInit() {
//     fetchProperties();
//     super.onInit();
//   }
//
//   Future<void> fetchProperties() async {
//     try {
//       isLoading(true);
//       var headers = {
//         'Cookie': 'ci_session=3fb359700b5bfe52ced1fc876f9390b37aee9b0b'
//       };
//
//       var request = http.MultipartRequest(
//         'GET',
//         Uri.parse(
//             'https://madanvasu.in/new/apis/Api_properties_list_by_status/properties_list_by_status?property_status_id=2'),
//       );
//
//       request.headers.addAll(headers);
//
//       http.StreamedResponse response = await request.send();
//
//       if (response.statusCode == 200) {
//         String responseBody = await response.stream.bytesToString();
//         final decoded = jsonDecode(responseBody);
//         final model = PropertiesListModel.fromJson(decoded);
//
//         if (model.data != null) {
//           propertiesList.value = model.data!;
//         }
//       } else {
//         Get.snackbar("Error", "Failed to load data: ${response.reasonPhrase}");
//       }
//     } catch (e) {
//       Get.snackbar("Exception", e.toString());
//     } finally {
//       isLoading(false);
//     }
//   }
// }





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

  Future<void> fetchProperties() async {
    try {
      isLoading(true);

      final wrapper = await _repository.Available_PropertiesWrapper();

      if (wrapper != null) {
        propertiesList.value = wrapper.properties ?? [];
        categoriesList.value = wrapper.propertiesCategories ?? [];
        statesList.value = wrapper.states ?? [];
        districtsList.value = wrapper.districts ?? [];
        mandalsList.value = wrapper.mandals ?? [];
        villagesList.value = wrapper.villages ?? [];

        // Log fetched data for debugging
        print('Fetched Properties Count: ${propertiesList.length}');
        print('Fetched Villages Count: ${villagesList.length}');
        print('Properties Data:');
        for (var property in propertiesList) {
          print(
              'Property ID: ${property.id}, Title: ${property.title}, Village ID: ${property.villageId}, Village ID Type: ${property.villageId.runtimeType}');
        }
        print('Villages Data:');
        for (var village in villagesList) {
          print('Village ID: ${village.id}, Village Name: ${village.name}, Village ID Type: ${village.id.runtimeType}');
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
