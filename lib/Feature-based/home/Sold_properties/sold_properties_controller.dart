import 'package:get/get.dart';
import '../../../data/Api_services/user_api_services.dart';
import '../FeaturedPoperties/FeaturedProperties_model.dart';

class SoldPropertiesController extends GetxController {
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
    fetchSoldProperties();
    super.onInit();
  }

  Future<void> fetchSoldProperties() async {
    try {
      isLoading(true);

      final wrapper = await _repository.Sold_PropertiesWrapper();

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
