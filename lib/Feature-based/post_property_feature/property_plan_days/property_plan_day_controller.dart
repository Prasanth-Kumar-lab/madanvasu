// import 'dart:convert';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:madhanvasu_app/Feature-based/post_property_feature/property_plan_days/property_plan_days_model.dart';
//
// class PropertyPlanController extends GetxController {
//   var isLoading = true.obs;
//   var planDaysList = <PlanDayData>[].obs;
//
//   final String apiUrl = 'https://madanvasu.in/new/apis/Api_property_plan/get_property_plan_days';
//
//   @override
//   void onInit() {
//     fetchPlanDays();
//     super.onInit();
//   }
//
//   void fetchPlanDays() async {
//     try {
//       isLoading.value = true;
//
//       var headers = {
//         'Cookie': 'ci_session=e120d6fb08532656fd24e7710ac5fda3238b2754',
//       };
//
//       var response = await http.get(Uri.parse(apiUrl), headers: headers);
//
//       if (response.statusCode == 200) {
//         final jsonData = jsonDecode(response.body);
//         final model = PropertyPlanDays.fromJson(jsonData);
//         if (model.data != null) {
//           planDaysList.assignAll(model.data!);
//         }
//       } else {
//         Get.snackbar("Error", response.reasonPhrase ?? "Unknown error");
//       }
//     } catch (e) {
//       Get.snackbar("Exception", e.toString());
//     } finally {
//       isLoading.value = false;
//     }
//   }
// }



import 'package:get/get.dart';
import 'package:madhanvasu_app/Feature-based/post_property_feature/property_plan_days/property_plan_days_model.dart';
import '../../../data/Api_services/user_api_services.dart';
class PropertyPlanController extends GetxController {
  var isLoading = true.obs;
  var planDaysList = <PlanDayData>[].obs;

  @override
  void onInit() {
    fetchPlanDays();
    super.onInit();
  }

  void fetchPlanDays() async {
    isLoading.value = true;

    final planDaysModel = await ApiService.fetchPlanDays();

    if (planDaysModel != null && planDaysModel.data != null) {
      planDaysList.assignAll(planDaysModel.data!);
    } else {
      Get.snackbar("Error", "Failed to load plan days");
    }

    isLoading.value = false;
  }
}
