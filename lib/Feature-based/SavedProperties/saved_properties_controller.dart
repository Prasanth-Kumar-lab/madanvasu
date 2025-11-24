import 'package:get/get.dart';
import 'package:madhanvasu_app/Feature-based/SavedProperties/saved_properties_model.dart';
import '../../data/Api_services/user_api_services.dart';
import '../../utils/shared_pref_helper.dart';

class FavoritePropertiesController extends GetxController {
  final ApiService repository;

  FavoritePropertiesController(this.repository);

  var isLoading = false.obs;
  var favoriteProperties = <FavoriteProperty>[].obs;
  var favoriteIds = <String>{}.obs;
  var error = ''.obs;

  @override
  void onInit() {
    super.onInit();
    favoriteProperties.clear();
    favoriteIds.clear();
    fetchFavorites();
  }

  Future<void> fetchFavorites() async {
    try {
      isLoading.value = true;
      error.value = '';

      final userId = await SharedPrefHelper.getUserData('id');

      if (userId == null || userId.isEmpty) {
        error.value = 'User ID not found';
        favoriteProperties.clear();
        favoriteIds.clear();
        return;
      }

      final response = await repository.fetchFavoriteProperties(userId);
      final properties = response.data?.favoriteProperties ?? [];

      favoriteProperties.assignAll(properties);
      favoriteIds.assignAll(properties.map((e) => e.id ?? '').where((id) => id.isNotEmpty));
    } catch (e) {
      error.value = 'Failed to load favorites: $e';
      favoriteProperties.clear();
      favoriteIds.clear();
      print('Error fetching favorites: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshFavorites() async {
    await fetchFavorites();
  }

  bool isFavorite(String propertyId) {
    return favoriteIds.contains(propertyId);
  }

  void toggleFavorite(FavoriteProperty property) {
    if (property.id == null) return;

    if (favoriteIds.contains(property.id)) {
      favoriteIds.remove(property.id);
      favoriteProperties.removeWhere((e) => e.id == property.id);
    } else {
      favoriteIds.add(property.id!);
      favoriteProperties.add(property);
    }
  }

  void toggleFavoriteById(String propertyId) {
    if (favoriteIds.contains(propertyId)) {
      favoriteIds.remove(propertyId);
      favoriteProperties.removeWhere((e) => e.id == propertyId);
    } else {
      favoriteIds.add(propertyId);
    }
  }

  Future<bool> addFavorite(String propertyId) async {
    try {
      final userId = await SharedPrefHelper.getUserData('id');
      if (userId == null || userId.isEmpty) {
        return false;
      }

      await ApiService.addFavoriteProperty(
        userId: userId,
        propertyId: propertyId,
      );

      favoriteIds.add(propertyId);
      return true;
    } catch (e) {
      print('Error adding favorite: $e');
      return false;
    }
  }

  Future<bool> removeFavorite(String propertyId) async {
    try {
      final userId = await SharedPrefHelper.getUserData('id');
      if (userId == null || userId.isEmpty) {
        return false;
      }

      await ApiService.removeFavoriteProperty(
        userId: userId,
        propertyId: propertyId,
      );

      favoriteIds.remove(propertyId);
      favoriteProperties.removeWhere((e) => e.id == propertyId);
      return true;
    } catch (e) {
      print('Error removing favorite: $e');
      return false;
    }
  }
}
