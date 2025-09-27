import 'package:get/get.dart';
import '../../../data/Api_services/user_api_services.dart';
import 'List_Reviews_model.dart';

class PropertyReviewController extends GetxController {
  final ApiService repository = ApiService();

  var isLoading = false.obs;
  var reviewData = Rxn<ReviewData>();

  final String propertyId = '14'; // Could be passed dynamically in future

  @override
  void onInit() {
    super.onInit();
    fetchReviews(); // No parameter needed now
  }

  Future<void> fetchReviews() async {
    isLoading.value = true;
    try {
      final PropertyReviewResponse response =
      await repository.fetchPropertyReviews(propertyId);
      reviewData.value = response.data;
    } catch (e) {
      print('Error fetching property reviews: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
