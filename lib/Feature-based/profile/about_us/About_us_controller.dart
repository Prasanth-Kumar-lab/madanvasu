import 'package:get/get.dart';

import '../../../data/Api_services/user_api_services.dart';

class AboutUsController extends GetxController {
  var isLoading = true.obs;
  var aboutTitle = ''.obs;
  var aboutDescription = ''.obs;
  var aboutImage = ''.obs;

  final ApiService _apiService = ApiService();

  @override
  void onInit() {
    super.onInit();
    fetchAboutUs();
  }

  Future<void> fetchAboutUs() async {
    isLoading(true);
    try {
      final data = await _apiService.fetchAboutUsData();

      if (data != null && data['status'] == true && data['data'].isNotEmpty) {
        final aboutData = data['data'][0];
        aboutTitle.value = aboutData['about_title'];
        aboutDescription.value = aboutData['about_desc'];
        aboutImage.value = aboutData['about_image'];
      } else {
        aboutDescription.value = 'No about us data available';
      }
    } catch (e) {
      aboutDescription.value = 'Error: $e';
    } finally {
      isLoading(false);
    }
  }
}

