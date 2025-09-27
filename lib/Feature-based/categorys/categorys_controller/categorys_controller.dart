
import 'package:get/get.dart';
import '../../../../data/Api_services/user_api_services.dart';
import '../categorys_model/categorys_model.dart';

class CategoryController extends GetxController {
  var categories = <CategoryData>[].obs;
  var isLoading = true.obs;

  final ApiService _categoryRepo = ApiService();

  @override
  void onInit() {
    fetchCategories();
    super.onInit();
  }

  void fetchCategories() async {
    try {
      isLoading(true);
      final result = await _categoryRepo.fetchCategories();
      categories.assignAll(result);
    } catch (e) {
      print("Controller Error: $e");
    } finally {
      isLoading(false);
    }
  }
}
