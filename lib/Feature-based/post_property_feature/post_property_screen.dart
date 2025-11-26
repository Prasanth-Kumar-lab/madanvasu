import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:madhanvasu_app/endpoints/endpoints.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'dart:convert';
import '../../../app/configuration/themes/app_colors.dart';
import '../../utils/shared_pref_helper.dart';
import '../categorys/categorys_controller/categorys_controller.dart';
import '../categorys/categorys_model/categorys_model.dart';
import '../property_status/property_status_list_controller.dart';
import '../states&districts/districts/distric_controller.dart';
import '../states&districts/districts/districts_model.dart';
import '../states&districts/mandals/mandals_controller.dart';
import '../states&districts/mandals/mandals_model.dart';
import '../states&districts/states/States_model.dart';
import '../states&districts/states/states_controller.dart';
import '../states&districts/villages/villages_controller.dart';
import '../states&districts/villages/villages_model.dart';
import 'customer_property_plan/customer_plan_controller.dart';
import 'package:madhanvasu_app/Feature-based/post_property_feature/property_plan_days/property_plan_day_controller.dart';
import 'package:madhanvasu_app/Feature-based/post_property_feature/property_price_per_day/price_per_days_Controller.dart';
import 'package:madhanvasu_app/Feature-based/post_property_feature/property_price_per_day/price_per_days_modle.dart';

class PincodeData {
  final double latitude;
  final double longitude;

  PincodeData({required this.latitude, required this.longitude});

  factory PincodeData.fromJson(List<dynamic> json) {
    return PincodeData(
      latitude: double.parse(json[0]['lat']),
      longitude: double.parse(json[0]['lon']),
    );
  }
}

class CreatePropertyController extends GetxController {
  String? userId;

  final titleController = TextEditingController();
  final propertyForController = TextEditingController();
  final propertyCategoryController = TextEditingController();
  final propertyStatusController = TextEditingController();
  final priceController = TextEditingController();
  final bookingAmountController = TextEditingController();
  final maintenanceChargesController = TextEditingController();
  final reraNumberController = TextEditingController();
  final streetNameController = TextEditingController();
  final pinCodeController = TextEditingController();
  final propertyPlanController = Get.put(PropertyPlanController());
  final customerPlanController = Get.put(CustomerPlanController());
  // final longitudeController = TextEditingController(text: '78.1245');
  final longitudeController = TextEditingController();
  // final latitudeController = TextEditingController(text: '78.1245');
  final latitudeController = TextEditingController();

  final floorPlanTitleController = TextEditingController();
  final floorPlanAreaController = TextEditingController();
  final floorPlanDescriptionController = TextEditingController();

  // Category-specific controllers
  final totalAreaController = TextEditingController();
  final builtupAreaController = TextEditingController();
  final bedroomsController = TextEditingController();
  final bathroomsController = TextEditingController();
  final parkingController = TextEditingController();
  final villaBuiltupAreaController = TextEditingController();
  final villaFloorsController = TextEditingController();
  final villaGardenController = TextEditingController();
  final plotAreaController = TextEditingController();
  final plotLengthController = TextEditingController();
  final plotWidthController = TextEditingController();
  final facingDirectionController = TextEditingController();
  final commercialAreaController = TextEditingController();
  final floorLevelController = TextEditingController();
  final suitableForController = TextEditingController();

  var isLoading = false.obs;
  var selectedState = Rxn<StatesModelData>();
  var selectedDistrict = Rxn<DistrictData>();
  var selectedMandal = Rxn<MandalData>();
  var selectedVillage = Rxn<VillageData>();
  var selectedCategory = Rxn<CategoryData>();
  var selectedPropertyFor = RxnString();
  var selectedPropertyStatus = RxnString();
  var currentStep = 0.obs;
  var propertyId = RxnString();

  final stateController = Get.find<StateController>();
  final districtController = Get.find<DistrictController>();
  final mandalController = Get.find<MandalController>();
  final villageController = Get.find<VillageController>();

  @override
  void onInit() {
    super.onInit();
    _loadUserData();
    // Initialize dropdown values to ensure they are preserved
    ever(selectedPropertyFor, (_) => _syncPropertyForController());
    ever(selectedCategory, (_) => _syncCategoryController());
    ever(selectedPropertyStatus, (_) => _syncPropertyStatusController());
    ever(selectedState, (_) => _syncStateController());
    ever(selectedDistrict, (_) => _syncDistrictController());
    ever(selectedMandal, (_) => _syncMandalController());
    ever(selectedVillage, (_) => _syncVillageController());
  }

  String? username;
  String? email;
  String? mobileNumber;

  Future<void> _loadUserData() async {
    userId = await SharedPrefHelper.getUserData('id');
    username = await SharedPrefHelper.getUserData('personName');
    email = await SharedPrefHelper.getUserData('email');
    mobileNumber = await SharedPrefHelper.getUserData('mobileNumber');
  }

  // Sync functions to ensure dropdown values are preserved
  void _syncPropertyForController() {
    if (selectedPropertyFor.value != null && selectedPropertyFor.value != propertyForController.text) {
      propertyForController.text = selectedPropertyFor.value!;
    }
  }

  void _syncCategoryController() {
    if (selectedCategory.value != null && selectedCategory.value!.id != propertyCategoryController.text) {
      propertyCategoryController.text = selectedCategory.value!.id;
    }
  }

  void _syncPropertyStatusController() {
    if (selectedPropertyStatus.value != null && selectedPropertyStatus.value != propertyStatusController.text) {
      propertyStatusController.text = selectedPropertyStatus.value!;
    }
  }

  void _syncStateController() {
    if (selectedState.value != null) {
      selectedDistrict.value = null;
      selectedMandal.value = null;
      selectedVillage.value = null;
      districtController.clearDistricts();
      mandalController.clearMandals();
      villageController.clearVillages();
    }
  }

  void _syncDistrictController() {
    if (selectedDistrict.value != null) {
      selectedMandal.value = null;
      selectedVillage.value = null;
      mandalController.clearMandals();
      villageController.clearVillages();
    }
  }

  void _syncMandalController() {
    if (selectedMandal.value != null) {
      selectedVillage.value = null;
      villageController.clearVillages();
    }
  }

  void _syncVillageController() {
    // No text controller for village
  }

  Future<void> fetchCoordinatesFromPincode(String pincode) async {
    if (pincode.isEmpty || pincode.length != 6) return;

    try {
      final response = await http.get(
        Uri.parse('https://nominatim.openstreetmap.org/search?postalcode=$pincode&country=India&format=json'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        if (data.isNotEmpty) {
          final pincodeData = PincodeData.fromJson(data);
          latitudeController.text = pincodeData.latitude.toStringAsFixed(6);
          longitudeController.text = pincodeData.longitude.toStringAsFixed(6);
        } else {
          Get.snackbar('Error', 'No location found for this pincode',
              backgroundColor: Colors.red, colorText: Colors.white);
        }
      }
    } catch (e) {
      print('Error fetching coordinates: $e');
    }
  }

  void updateCategoryData(CategoryData? categoryData) {
    if (categoryData != null && selectedCategory.value?.id != categoryData.id) {
      selectedCategory.value = categoryData;
      propertyCategoryController.text = categoryData.id;
      clearCategorySpecificFields();
    }
  }

  void clearCategorySpecificFields() {
    totalAreaController.clear();
    builtupAreaController.clear();
    bedroomsController.clear();
    bathroomsController.clear();
    parkingController.clear();
    villaBuiltupAreaController.clear();
    villaFloorsController.clear();
    villaGardenController.clear();
    plotAreaController.clear();
    plotLengthController.clear();
    plotWidthController.clear();
    facingDirectionController.clear();
    commercialAreaController.clear();
    floorLevelController.clear();
    suitableForController.clear();
  }

  Map<String, String> get formData {
    final data = {
      'user_id': userId ?? '',
      'title': titleController.text,
      'property_for': propertyForController.text,
      'property_cat_id': propertyCategoryController.text,
      'property_status_id': propertyStatusController.text,
      'price': priceController.text,
      'booking_amount': bookingAmountController.text,
      'maintenance_charges': maintenanceChargesController.text,
      'rera_number': reraNumberController.text,
      'state_id': selectedState.value?.id?.toString() ?? '',
      'district_id': selectedDistrict.value?.id?.toString() ?? '',
      'mandal_id': selectedMandal.value?.id?.toString() ?? '',
      'village_id': selectedVillage.value?.id?.toString() ?? '',
      'street_name': streetNameController.text,
      'pin_code': pinCodeController.text,
      'longitude': longitudeController.text,
      'latitude': latitudeController.text,
      'floor_plan_title': floorPlanTitleController.text,
      'floor_plan_area': floorPlanAreaController.text,
      'description': floorPlanDescriptionController.text,
      // 'active': 'Active',
    };

    if (selectedCategory.value?.propertyCategoryTitle == 'Apartment') {
      data.addAll({
        'total_area': totalAreaController.text,
        'builtup_area': builtupAreaController.text,
        'bedrooms': bedroomsController.text,
        'bathrooms': bathroomsController.text,
        'parking': parkingController.text,
      });
    } else if (selectedCategory.value?.propertyCategoryTitle == 'Villa') {
      data.addAll({
        'villa_builtup_area': villaBuiltupAreaController.text,
        'villa_floors': villaFloorsController.text,
        'villa_garden': villaGardenController.text,
      });
    } else if (selectedCategory.value?.propertyCategoryTitle == 'Plot') {
      data.addAll({
        'plot_area': plotAreaController.text,
        'plot_length': plotLengthController.text,
        'plot_width': plotWidthController.text,
        'facing_direction': facingDirectionController.text,
      });
    } else if (selectedCategory.value?.propertyCategoryTitle == 'Commercial Space') {
      data.addAll({
        'commercial_area': commercialAreaController.text,
        'floor_level': floorLevelController.text,
        'suitable_for': suitableForController.text,
      });
    }

    return data;
  }

  Future<bool> submitProperty(GlobalKey<FormState> formKey) async {
    if (!formKey.currentState!.validate()) {
      Get.snackbar('Error', 'Please fill all required fields', backgroundColor: Colors.red, colorText: Colors.white);
      return false;
    }

    if (userId == null || userId!.isEmpty) {
      Get.snackbar('Error', 'User ID not found. Please login again.', backgroundColor: Colors.red, colorText: Colors.white);
      return false;
    }

    if (selectedPropertyFor.value == null ||
        propertyCategoryController.text.isEmpty ||
        selectedPropertyStatus.value == null ||
        selectedState.value?.id == null ||
        selectedDistrict.value?.id == null ||
        selectedMandal.value?.id == null ||
        selectedVillage.value?.id == null) {
      Get.snackbar('Error', 'Please complete all required selections', backgroundColor: Colors.red, colorText: Colors.white);
      return false;
    }

    isLoading.value = true;
    var headers = {'Cookie': 'ci_session=f1b618f9f875d808eb351470566184311786b179'};

    var request = http.MultipartRequest(
      'POST',
      Uri.parse('https://madanvasu.in/new/apis/Api_properties/create_property'),
    );

    request.fields.addAll(formData);
    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();
      String responseBody = await response.stream.bytesToString();
      print('API Responseeeeee: ${response.statusCode}, Body: $responseBody');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = json.decode(responseBody);
        if (responseData['status'] == true && responseData['property_id'] != null) {
          propertyId.value = responseData['property_id'].toString();
          Get.snackbar('Success', 'Property created successfully!', backgroundColor: Colors.green, colorText: Colors.white);

          // DO NOT reset form fields here - keep them until payment is complete
          return true;
        } else {
          Get.snackbar('Error', 'Failed: $responseBody', backgroundColor: Colors.red, colorText: Colors.white);
          return false;
        }
      } else {
        Get.snackbar('Error', 'Failed: $responseBody', backgroundColor: Colors.red, colorText: Colors.white);
        return false;
      }
    } catch (e) {
      print('Exception during submission: $e');
      Get.snackbar('Error', 'Exception: $e', backgroundColor: Colors.red, colorText: Colors.white);
      return false;
    } finally {
      isLoading.value = false;
    }
  }

// Add this method to clear form only when payment is successful
  void clearFormAfterSuccessfulPayment() {
    titleController.clear();
    propertyForController.clear();
    propertyCategoryController.clear();
    propertyStatusController.clear();
    priceController.clear();
    bookingAmountController.clear();
    maintenanceChargesController.clear();
    reraNumberController.clear();
    streetNameController.clear();
    pinCodeController.clear();
    longitudeController.clear();
    latitudeController.clear();
    floorPlanTitleController.clear();
    floorPlanAreaController.clear();
    floorPlanDescriptionController.clear();
    clearCategorySpecificFields();
    selectedState.value = null;
    selectedDistrict.value = null;
    selectedMandal.value = null;
    selectedVillage.value = null;
    selectedCategory.value = null;
    selectedPropertyFor.value = null;
    selectedPropertyStatus.value = null;
    currentStep.value = 0;
    propertyId.value = null;
  }

  @override
  void onClose() {
    titleController.dispose();
    propertyForController.dispose();
    propertyCategoryController.dispose();
    propertyStatusController.dispose();
    priceController.dispose();
    bookingAmountController.dispose();
    maintenanceChargesController.dispose();
    reraNumberController.dispose();
    streetNameController.dispose();
    pinCodeController.dispose();
    longitudeController.dispose();
    latitudeController.dispose();
    floorPlanTitleController.dispose();
    floorPlanAreaController.dispose();
    floorPlanDescriptionController.dispose();
    totalAreaController.dispose();
    builtupAreaController.dispose();
    bedroomsController.dispose();
    bathroomsController.dispose();
    parkingController.dispose();
    villaBuiltupAreaController.dispose();
    villaFloorsController.dispose();
    villaGardenController.dispose();
    plotAreaController.dispose();
    plotLengthController.dispose();
    plotWidthController.dispose();
    facingDirectionController.dispose();
    commercialAreaController.dispose();
    floorLevelController.dispose();
    suitableForController.dispose();
    super.onClose();
  }
}

// class CreateProperty_Screen extends StatelessWidget {
//   const CreateProperty_Screen({super.key});
//
//   Widget _buildTextField({
//     required TextEditingController controller,
//     required String label,
//     TextInputType? keyboardType,
//     String? Function(String?)? validator,
//     bool readOnly = false,
//     int maxLines = 1,
//     VoidCallback? onChanged,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Card(
//         elevation: 4,
//         shadowColor: Colors.grey.withOpacity(0.2),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//         child: TextFormField(
//           controller: controller,
//           readOnly: readOnly,
//           maxLines: maxLines,
//           decoration: InputDecoration(
//             labelText: label,
//             labelStyle: TextStyle(color: AppColors.secondary.withOpacity(0.8)),
//             filled: true,
//             fillColor: Colors.white,
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(16),
//               borderSide: BorderSide.none,
//             ),
//             prefixIcon: Icon(Icons.edit, color: AppColors.secondary),
//             contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//           ),
//           keyboardType: keyboardType,
//           validator: validator,
//           onChanged: onChanged != null ? (value) => onChanged() : null,
//           onSaved: (value) {
//             if (value != null) controller.text = value;
//           },
//         ),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(CreatePropertyController());
//     final propertyStatusController = Get.put(PropertyStatusController());
//     final categoryController = Get.find<CategoryController>();
//     final propertyPlanController = Get.put(PropertyPlanController());
//     final customerPlanController = Get.put(CustomerPlanController());
//     final propertyPriceController = PropertyPriceController();
//     final formKey1 = GlobalKey<FormState>();
//     final formKey2 = GlobalKey<FormState>();
//     final formKey3 = GlobalKey<FormState>();
//
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         backgroundColor: AppColors.primary.withOpacity(0.9),
//         title: const Text(
//           'List A Property',
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 22,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         centerTitle: true,
//         elevation: 2,
//       ),
//       body: Column(
//         children: [
//           Container(
//             color: AppColors.primary,
//             padding: const EdgeInsets.symmetric(vertical: 12),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 GestureDetector(
//                   onTap: () => controller.currentStep.value = 0,
//                   child: _buildStep('Property Details', controller.currentStep.value == 0, Icons.description),
//                 ),
//                 Expanded(
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                     child: Divider(
//                       color: Colors.white70,
//                       thickness: 2,
//                     ),
//                   ),
//                 ),
//                 GestureDetector(
//                   onTap: () => controller.currentStep.value = 1,
//                   child: _buildStep('Location Details', controller.currentStep.value == 1, Icons.location_on),
//                 ),
//                 Expanded(
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                     child: Divider(
//                       color: Colors.white70,
//                       thickness: 2,
//                     ),
//                   ),
//                 ),
//                 GestureDetector(
//                   onTap: () => controller.currentStep.value = 2,
//                   child: _buildStep('Floor Plan Details', controller.currentStep.value == 2, Icons.map),
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             child: Obx(() {
//               if (categoryController.isLoading.value || controller.isLoading.value || propertyStatusController.isLoading.value) {
//                 return const Center(child: CircularProgressIndicator(color: AppColors.secondary));
//               }
//
//               Widget content;
//               GlobalKey<FormState> currentFormKey;
//               String buttonText;
//               VoidCallback? onButtonPressed;
//
//               switch (controller.currentStep.value) {
//                 case 0:
//                   currentFormKey = formKey1;
//                   buttonText = 'Next';
//                   onButtonPressed = () {
//                     if (formKey1.currentState!.validate()) {
//                       // Sync dropdowns to controllers
//                       controller._syncPropertyForController();
//                       controller._syncCategoryController();
//                       controller._syncPropertyStatusController();
//
//                       // Validate dropdown selections
//                       if (controller.selectedPropertyFor.value == null || controller.propertyForController.text.isEmpty) {
//                         Get.snackbar('Error', 'Property for is required', backgroundColor: Colors.red, colorText: Colors.white);
//                         return;
//                       }
//                       if (controller.selectedCategory.value == null || controller.propertyCategoryController.text.isEmpty) {
//                         Get.snackbar('Error', 'Property category is required', backgroundColor: Colors.red, colorText: Colors.white);
//                         return;
//                       }
//                       if (controller.selectedPropertyStatus.value == null || controller.propertyStatusController.text.isEmpty) {
//                         Get.snackbar('Error', 'Property status is required', backgroundColor: Colors.red, colorText: Colors.white);
//                         return;
//                       }
//
//                       // Validate category-specific fields
//                       if (controller.selectedCategory.value != null) {
//                         final categoryTitle = controller.selectedCategory.value!.propertyCategoryTitle;
//                         if (categoryTitle == 'Apartment' &&
//                             (controller.totalAreaController.text.isEmpty ||
//                                 controller.builtupAreaController.text.isEmpty ||
//                                 controller.bedroomsController.text.isEmpty ||
//                                 controller.bathroomsController.text.isEmpty ||
//                                 controller.parkingController.text.isEmpty)) {
//                           Get.snackbar('Error', 'All apartment details are required', backgroundColor: Colors.red, colorText: Colors.white);
//                           return;
//                         } else if (categoryTitle == 'Villa' &&
//                             (controller.villaBuiltupAreaController.text.isEmpty ||
//                                 controller.villaFloorsController.text.isEmpty ||
//                                 controller.villaGardenController.text.isEmpty)) {
//                           Get.snackbar('Error', 'All villa details are required', backgroundColor: Colors.red, colorText: Colors.white);
//                           return;
//                         } else if (categoryTitle == 'Plot' &&
//                             (controller.plotAreaController.text.isEmpty ||
//                                 controller.plotLengthController.text.isEmpty ||
//                                 controller.plotWidthController.text.isEmpty ||
//                                 controller.facingDirectionController.text.isEmpty)) {
//                           Get.snackbar('Error', 'All plot details are required', backgroundColor: Colors.red, colorText: Colors.white);
//                           return;
//                         } else if (categoryTitle == 'Commercial Space' &&
//                             (controller.commercialAreaController.text.isEmpty ||
//                                 controller.floorLevelController.text.isEmpty ||
//                                 controller.suitableForController.text.isEmpty)) {
//                           Get.snackbar('Error', 'All commercial space details are required', backgroundColor: Colors.red, colorText: Colors.white);
//                           return;
//                         }
//                       }
//                       controller.currentStep.value = 1;
//                     }
//                   };
//                   content = Form(
//                     key: formKey1,
//                     child: ListView(
//                       padding: const EdgeInsets.all(16),
//                       children: [
//                         const Padding(
//                           padding: EdgeInsets.only(bottom: 16.0),
//                           child: Text(
//                             'Property Details',
//                             style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.primary),
//                           ),
//                         ),
//                         _buildTextField(
//                           controller: controller.titleController,
//                           label: 'Property Title',
//                           validator: (val) => val!.isEmpty ? 'Required' : null,
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(vertical: 8.0),
//                           child: Card(
//                             elevation: 4,
//                             shadowColor: Colors.grey.withOpacity(0.2),
//                             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//                             child: DropdownButtonFormField<String>(
//                               decoration: InputDecoration(
//                                 labelText: 'Property For',
//                                 labelStyle: TextStyle(color: AppColors.secondary.withOpacity(0.8)),
//                                 filled: true,
//                                 fillColor: Colors.white,
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(16),
//                                   borderSide: BorderSide.none,
//                                 ),
//                                 prefixIcon: Icon(Icons.category, color: AppColors.secondary),
//                                 contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//                               ),
//                               value: controller.selectedPropertyFor.value?.isNotEmpty == true
//                                   ? controller.selectedPropertyFor.value
//                                   : null,
//                               items: ['Sell', 'Rent'].map((propertyFor) {
//                                 return DropdownMenuItem<String>(
//                                   value: propertyFor,
//                                   child: Text(propertyFor),
//                                 );
//                               }).toList(),
//                               onChanged: (newValue) {
//                                 controller.selectedPropertyFor.value = newValue;
//                                 controller.propertyForController.text = newValue ?? '';
//                                 controller._syncPropertyForController();
//                               },
//                               validator: (val) => val == null || val.isEmpty ? 'Please select property for' : null,
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(vertical: 8.0),
//                           child: Card(
//                             elevation: 4,
//                             shadowColor: Colors.grey.withOpacity(0.2),
//                             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//                             child: DropdownButtonFormField<String>(
//                               isExpanded: true,
//                               decoration: InputDecoration(
//                                 labelText: 'Property Category',
//                                 labelStyle: TextStyle(color: AppColors.secondary.withOpacity(0.8)),
//                                 filled: true,
//                                 fillColor: Colors.white,
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(16),
//                                   borderSide: BorderSide.none,
//                                 ),
//                                 prefixIcon: Icon(Icons.category, color: AppColors.secondary),
//                                 contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//                               ),
//                               value: controller.propertyCategoryController.text.isNotEmpty
//                                   ? controller.propertyCategoryController.text
//                                   : null,
//                               items: categoryController.categories.map((category) {
//                                 return DropdownMenuItem<String>(
//                                   value: category.id,
//                                   child: Text(category.propertyCategoryTitle),
//                                 );
//                               }).toList(),
//                               onChanged: (newValue) {
//                                 if (newValue != null) {
//                                   controller.propertyCategoryController.text = newValue;
//                                   final selectedCategory = categoryController.categories
//                                       .firstWhere((cat) => cat.id == newValue);
//                                   controller.updateCategoryData(selectedCategory);
//                                   controller._syncCategoryController();
//                                 }
//                               },
//                               validator: (val) => val == null || val.isEmpty ? 'Please select a category' : null,
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(vertical: 8.0),
//                           child: Card(
//                             elevation: 4,
//                             shadowColor: Colors.grey.withOpacity(0.2),
//                             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//                             child: DropdownButtonFormField<String>(
//                               isExpanded: true,
//                               decoration: InputDecoration(
//                                 labelText: 'Property Status',
//                                 labelStyle: TextStyle(color: AppColors.secondary.withOpacity(0.8)),
//                                 filled: true,
//                                 fillColor: Colors.white,
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(16),
//                                   borderSide: BorderSide.none,
//                                 ),
//                                 prefixIcon: Icon(Icons.info, color: AppColors.secondary),
//                                 contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//                               ),
//                               value: controller.selectedPropertyStatus.value?.isNotEmpty == true
//                                   ? controller.selectedPropertyStatus.value
//                                   : null,
//                               items: propertyStatusController.propertyStatusList.map((status) {
//                                 return DropdownMenuItem<String>(
//                                   value: status.id,
//                                   child: Text(status.propertyStatus),
//                                 );
//                               }).toList(),
//                               onChanged: (newValue) {
//                                 controller.selectedPropertyStatus.value = newValue;
//                                 controller.propertyStatusController.text = newValue ?? '';
//                                 controller._syncPropertyStatusController();
//                               },
//                               validator: (val) => val == null || val.isEmpty ? 'Please select a status' : null,
//                             ),
//                           ),
//                         ),
//                         _buildTextField(
//                           controller: controller.priceController,
//                           label: 'Assking Price',
//                           keyboardType: TextInputType.number,
//                           validator: (val) => val!.isEmpty ? 'Required' : null,
//                         ),
//                         _buildTextField(
//                           controller: controller.bookingAmountController,
//                           label: 'Booking Amount',
//                           keyboardType: TextInputType.number,
//                         ),
//                         _buildTextField(
//                           controller: controller.maintenanceChargesController,
//                           label: 'Maintenance Charges',
//                           keyboardType: TextInputType.number,
//                         ),
//                         _buildTextField(
//                           controller: controller.reraNumberController,
//                           label: 'RERA Number',
//                         ),
//                         Obx(() {
//                           final category = controller.selectedCategory.value;
//                           if (category == null) return const SizedBox();
//                           if (category.propertyCategoryTitle == 'Apartment') {
//                             return Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 const Padding(
//                                   padding: EdgeInsets.symmetric(vertical: 16.0),
//                                   child: Text(
//                                     'Apartment Details',
//                                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.primary),
//                                   ),
//                                 ),
//                                 _buildTextField(
//                                   controller: controller.totalAreaController,
//                                   label: 'Total Area (sq.ft.)',
//                                   keyboardType: TextInputType.number,
//                                   validator: (val) => val!.isEmpty ? 'Required' : null,
//                                 ),
//                                 _buildTextField(
//                                   controller: controller.builtupAreaController,
//                                   label: 'Built-up Area (sq.ft.)',
//                                   keyboardType: TextInputType.number,
//                                   validator: (val) => val!.isEmpty ? 'Required' : null,
//                                 ),
//                                 _buildTextField(
//                                   controller: controller.bedroomsController,
//                                   label: 'Number of Bedrooms',
//                                   keyboardType: TextInputType.number,
//                                   validator: (val) => val!.isEmpty ? 'Required' : null,
//                                 ),
//                                 _buildTextField(
//                                   controller: controller.bathroomsController,
//                                   label: 'Number of Bathrooms',
//                                   keyboardType: TextInputType.number,
//                                   validator: (val) => val!.isEmpty ? 'Required' : null,
//                                 ),
//                                 _buildTextField(
//                                   controller: controller.parkingController,
//                                   label: 'Parking Availability',
//                                   validator: (val) => val!.isEmpty ? 'Required' : null,
//                                 ),
//                               ],
//                             );
//                           } else if (category.propertyCategoryTitle == 'Villa') {
//                             return Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 const Padding(
//                                   padding: EdgeInsets.symmetric(vertical: 16.0),
//                                   child: Text(
//                                     'Villa Details',
//                                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.primary),
//                                   ),
//                                 ),
//                                 _buildTextField(
//                                   controller: controller.villaBuiltupAreaController,
//                                   label: 'Built-up Area (sq.ft.)',
//                                   keyboardType: TextInputType.number,
//                                   validator: (val) => val!.isEmpty ? 'Required' : null,
//                                 ),
//                                 _buildTextField(
//                                   controller: controller.villaFloorsController,
//                                   label: 'Number of Floors',
//                                   keyboardType: TextInputType.number,
//                                   validator: (val) => val!.isEmpty ? 'Required' : null,
//                                 ),
//                                 _buildTextField(
//                                   controller: controller.villaGardenController,
//                                   label: 'Garden Area (sq.ft.)',
//                                   keyboardType: TextInputType.number,
//                                   validator: (val) => val!.isEmpty ? 'Required' : null,
//                                 ),
//                               ],
//                             );
//                           } else if (category.propertyCategoryTitle == 'Plot') {
//                             return Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 const Padding(
//                                   padding: EdgeInsets.symmetric(vertical: 16.0),
//                                   child: Text(
//                                     'Plot Details',
//                                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.primary),
//                                   ),
//                                 ),
//                                 _buildTextField(
//                                   controller: controller.plotAreaController,
//                                   label: 'Plot Area (sq.ft.)',
//                                   keyboardType: TextInputType.number,
//                                   validator: (val) => val!.isEmpty ? 'Required' : null,
//                                 ),
//                                 _buildTextField(
//                                   controller: controller.plotLengthController,
//                                   label: 'Plot Length (ft.)',
//                                   keyboardType: TextInputType.number,
//                                   validator: (val) => val!.isEmpty ? 'Required' : null,
//                                 ),
//                                 _buildTextField(
//                                   controller: controller.plotWidthController,
//                                   label: 'Plot Width (ft.)',
//                                   keyboardType: TextInputType.number,
//                                   validator: (val) => val!.isEmpty ? 'Required' : null,
//                                 ),
//                                 _buildTextField(
//                                   controller: controller.facingDirectionController,
//                                   label: 'Facing Direction',
//                                   validator: (val) => val!.isEmpty ? 'Required' : null,
//                                 ),
//                               ],
//                             );
//                           } else if (category.propertyCategoryTitle == 'Commercial Space') {
//                             return Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 const Padding(
//                                   padding: EdgeInsets.symmetric(vertical: 16.0),
//                                   child: Text(
//                                     'Commercial Space Details',
//                                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.primary),
//                                   ),
//                                 ),
//                                 _buildTextField(
//                                   controller: controller.commercialAreaController,
//                                   label: 'Commercial Area (sq.ft.)',
//                                   keyboardType: TextInputType.number,
//                                   validator: (val) => val!.isEmpty ? 'Required' : null,
//                                 ),
//                                 _buildTextField(
//                                   controller: controller.floorLevelController,
//                                   label: 'Floor Level',
//                                   keyboardType: TextInputType.number,
//                                   validator: (val) => val!.isEmpty ? 'Required' : null,
//                                 ),
//                                 _buildTextField(
//                                   controller: controller.suitableForController,
//                                   label: 'Suitable For',
//                                   validator: (val) => val!.isEmpty ? 'Required' : null,
//                                 ),
//                               ],
//                             );
//                           }
//                           return const SizedBox();
//                         }),
//                       ],
//                     ),
//                   );
//                   break;
//                 case 1:
//                   currentFormKey = formKey2;
//                   buttonText = 'Next';
//                   onButtonPressed = () {
//                     if (formKey2.currentState!.validate()) {
//                       if (controller.selectedState.value == null) {
//                         Get.snackbar('Error', 'Please select a state', backgroundColor: Colors.red, colorText: Colors.white);
//                         return;
//                       }
//                       if (controller.selectedDistrict.value == null) {
//                         Get.snackbar('Error', 'Please select a district', backgroundColor: Colors.red, colorText: Colors.white);
//                         return;
//                       }
//                       if (controller.selectedMandal.value == null) {
//                         Get.snackbar('Error', 'Please select a mandal', backgroundColor: Colors.red, colorText: Colors.white);
//                         return;
//                       }
//                       if (controller.selectedVillage.value == null) {
//                         Get.snackbar('Error', 'Please select a village', backgroundColor: Colors.red, colorText: Colors.white);
//                         return;
//                       }
//                       if (controller.pinCodeController.text.isEmpty) {
//                         Get.snackbar('Error', 'Pin code is required', backgroundColor: Colors.red, colorText: Colors.white);
//                         return;
//                       }
//                       controller.currentStep.value = 2;
//                     }
//                   };
//                   content = Form(
//                     key: formKey2,
//                     child: ListView(
//                       padding: const EdgeInsets.all(16),
//                       children: [
//                         const Padding(
//                           padding: EdgeInsets.only(bottom: 16.0),
//                           child: Text(
//                             'Location Details',
//                             style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.primary),
//                           ),
//                         ),
//                         // Obx(() {
//                         //   final states = controller.stateController.statesList;
//                         //   if (controller.stateController.isLoading.value) {
//                         //     return const Center(child: CircularProgressIndicator(color: AppColors.secondary));
//                         //   }
//                         //   if (states.isEmpty) {
//                         //     return const Padding(
//                         //       padding: EdgeInsets.symmetric(vertical: 8.0),
//                         //       child: Text('No states available', style: TextStyle(color: Colors.red)),
//                         //     );
//                         //   }
//                         //   return Padding(
//                         //     padding: const EdgeInsets.symmetric(vertical: 8.0),
//                         //     child: Card(
//                         //       elevation: 4,
//                         //       shadowColor: Colors.grey.withOpacity(0.2),
//                         //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//                         //       child: DropdownButtonFormField<StatesModelData>(
//                         //         isExpanded: true,
//                         //         decoration: InputDecoration(
//                         //           labelText: 'Select State',
//                         //           labelStyle: TextStyle(color: AppColors.secondary.withOpacity(0.8)),
//                         //           filled: true,
//                         //           fillColor: Colors.white,
//                         //           border: OutlineInputBorder(
//                         //             borderRadius: BorderRadius.circular(16),
//                         //             borderSide: BorderSide.none,
//                         //           ),
//                         //           prefixIcon: Icon(Icons.flag, color: AppColors.secondary),
//                         //           contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//                         //         ),
//                         //         value: controller.selectedState.value,
//                         //         items: states.map((state) {
//                         //           return DropdownMenuItem<StatesModelData>(
//                         //             value: state,
//                         //             child: Text(state.stateName ?? ''),
//                         //           );
//                         //         }).toList(),
//                         //         onChanged: (value) async {
//                         //           controller.selectedState.value = value;
//                         //           controller.selectedDistrict.value = null;
//                         //           controller.selectedMandal.value = null;
//                         //           controller.selectedVillage.value = null;
//                         //           controller.districtController.clearDistricts();
//                         //           controller.mandalController.clearMandals();
//                         //           controller.villageController.clearVillages();
//                         //           if (value != null) {
//                         //             await controller.districtController.fetchDistricts(value.id!);
//                         //           }
//                         //         },
//                         //         validator: (value) => value == null ? 'Please select a state' : null,
//                         //       ),
//                         //     ),
//                         //   );
//                         // }),
//
//                         Obx(() {
//                           final states = controller.stateController.statesList;
//
//                           if (controller.stateController.isLoading.value) {
//                             return const Center(child: CircularProgressIndicator(color: AppColors.secondary));
//                           }
//
//                           if (states.isEmpty) {
//                             return const Padding(
//                               padding: EdgeInsets.symmetric(vertical: 8.0),
//                               child: Text('No states available', style: TextStyle(color: Colors.red)),
//                             );
//                           }
//
//                           return Padding(
//                             padding: const EdgeInsets.symmetric(vertical: 8.0),
//                             child: Card(
//                               elevation: 4,
//                               shadowColor: Colors.grey.withOpacity(0.2),
//                               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//                               child: DropdownSearch<StatesModelData>(
//                                 items: states,
//                                 selectedItem: controller.selectedState.value,
//                                 itemAsString: (state) => state.stateName ?? '',
//                                 dropdownDecoratorProps: DropDownDecoratorProps(
//                                   dropdownSearchDecoration: InputDecoration(
//                                     labelText: 'Select State',
//                                     labelStyle: TextStyle(color: AppColors.secondary.withOpacity(0.8)),
//                                     filled: true,
//                                     fillColor: Colors.white,
//                                     border: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(16),
//                                       borderSide: BorderSide.none,
//                                     ),
//                                     prefixIcon: Icon(Icons.flag, color: AppColors.secondary),
//                                     contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//                                   ),
//                                 ),
//                                 popupProps: PopupProps.menu(
//                                   showSearchBox: true,
//                                   searchFieldProps: TextFieldProps(
//                                     decoration: InputDecoration(
//                                       hintText: 'Search states...',
//                                       prefixIcon: Icon(Icons.search),
//                                       border: OutlineInputBorder(
//                                         borderRadius: BorderRadius.circular(12),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 onChanged: (value) async {
//                                   controller.selectedState.value = value;
//                                   controller.selectedDistrict.value = null;
//                                   controller.selectedMandal.value = null;
//                                   controller.selectedVillage.value = null;
//                                   controller.districtController.clearDistricts();
//                                   controller.mandalController.clearMandals();
//                                   controller.villageController.clearVillages();
//                                   if (value != null) {
//                                     await controller.districtController.fetchDistricts(value.id!);
//                                   }
//                                 },
//                                 validator: (value) => value == null ? 'Please select a state' : null,
//                               ),
//                             ),
//                           );
//                         }),
//
//
//
//                         // Obx(() {
//                         //   final selectedState = controller.selectedState.value;
//                         //   final districts = controller.districtController.districtList;
//                         //   final isDistrictLoading = controller.districtController.isLoading.value;
//                         //   if (selectedState == null) return const SizedBox();
//                         //   if (isDistrictLoading) return const Center(child: CircularProgressIndicator(color: AppColors.secondary));
//                         //   if (districts.isEmpty) {
//                         //     return const Padding(
//                         //       padding: EdgeInsets.symmetric(vertical: 8.0),
//                         //       child: Text('No districts available', style: TextStyle(color: Colors.red)),
//                         //     );
//                         //   }
//                         //   return Padding(
//                         //     padding: const EdgeInsets.symmetric(vertical: 8.0),
//                         //     child: Card(
//                         //       elevation: 4,
//                         //       shadowColor: Colors.grey.withOpacity(0.2),
//                         //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//                         //       child: DropdownButtonFormField<DistrictData>(
//                         //         isExpanded: true,
//                         //         decoration: InputDecoration(
//                         //           labelText: 'Select District',
//                         //           labelStyle: TextStyle(color: AppColors.secondary.withOpacity(0.8)),
//                         //           filled: true,
//                         //           fillColor: Colors.white,
//                         //           border: OutlineInputBorder(
//                         //             borderRadius: BorderRadius.circular(16),
//                         //             borderSide: BorderSide.none,
//                         //           ),
//                         //           prefixIcon: Icon(Icons.location_city, color: AppColors.secondary),
//                         //           contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//                         //         ),
//                         //         value: controller.selectedDistrict.value,
//                         //         items: districts.map((district) {
//                         //           return DropdownMenuItem<DistrictData>(
//                         //             value: district,
//                         //             child: Text(district.districtName),
//                         //           );
//                         //         }).toList(),
//                         //         onChanged: (value) async {
//                         //           controller.selectedDistrict.value = value;
//                         //           controller.selectedMandal.value = null;
//                         //           controller.selectedVillage.value = null;
//                         //           controller.mandalController.clearMandals();
//                         //           controller.villageController.clearVillages();
//                         //           if (value != null && controller.selectedState.value != null) {
//                         //             await controller.mandalController.fetchMandals(
//                         //               stateId: controller.selectedState.value!.id!,
//                         //               districtId: value.id!,
//                         //             );
//                         //           }
//                         //         },
//                         //         validator: (value) => value == null ? 'Please select a district' : null,
//                         //       ),
//                         //     ),
//                         //   );
//                         // }),
//
//                         Obx(() {
//                           final selectedState = controller.selectedState.value;
//                           final districts = controller.districtController.districtList;
//                           final isDistrictLoading = controller.districtController.isLoading.value;
//
//                           if (selectedState == null) return const SizedBox();
//
//                           if (isDistrictLoading) {
//                             return const Center(child: CircularProgressIndicator(color: AppColors.secondary));
//                           }
//
//                           if (districts.isEmpty) {
//                             return const Padding(
//                               padding: EdgeInsets.symmetric(vertical: 8.0),
//                               child: Text('No districts available', style: TextStyle(color: Colors.red)),
//                             );
//                           }
//
//                           return Padding(
//                             padding: const EdgeInsets.symmetric(vertical: 8.0),
//                             child: Card(
//                               elevation: 4,
//                               shadowColor: Colors.grey.withOpacity(0.2),
//                               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//                               child: DropdownSearch<DistrictData>(
//                                 items: districts,
//                                 selectedItem: controller.selectedDistrict.value,
//                                 itemAsString: (DistrictData district) => district.districtName,
//                                 popupProps: PopupProps.menu(
//                                   showSearchBox: true,
//                                   searchFieldProps: TextFieldProps(
//                                     decoration: InputDecoration(
//                                       hintText: 'Search districts...',
//                                       prefixIcon: Icon(Icons.search),
//                                       border: OutlineInputBorder(
//                                         borderRadius: BorderRadius.circular(12),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 dropdownDecoratorProps: DropDownDecoratorProps(
//                                   dropdownSearchDecoration: InputDecoration(
//                                     labelText: 'Select District',
//                                     labelStyle: TextStyle(color: AppColors.secondary.withOpacity(0.8)),
//                                     filled: true,
//                                     fillColor: Colors.white,
//                                     border: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(16),
//                                       borderSide: BorderSide.none,
//                                     ),
//                                     prefixIcon: Icon(Icons.location_city, color: AppColors.secondary),
//                                     contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//                                   ),
//                                 ),
//                                 onChanged: (value) async {
//                                   controller.selectedDistrict.value = value;
//                                   controller.selectedMandal.value = null;
//                                   controller.selectedVillage.value = null;
//                                   controller.mandalController.clearMandals();
//                                   controller.villageController.clearVillages();
//                                   if (value != null && controller.selectedState.value != null) {
//                                     await controller.mandalController.fetchMandals(
//                                       stateId: controller.selectedState.value!.id!,
//                                       districtId: value.id!,
//                                     );
//                                   }
//                                 },
//                                 validator: (value) => value == null ? 'Please select a district' : null,
//                               ),
//                             ),
//                           );
//                         }),
//
//                         // Obx(() {
//                         //   final selectedDistrict = controller.selectedDistrict.value;
//                         //   final mandals = controller.mandalController.mandalList;
//                         //   final isMandalLoading = controller.mandalController.isLoading.value;
//                         //   if (selectedDistrict == null || (!isMandalLoading && mandals.isEmpty)) return const SizedBox();
//                         //   if (isMandalLoading) return const Center(child: CircularProgressIndicator(color: AppColors.secondary));
//                         //   return Padding(
//                         //     padding: const EdgeInsets.symmetric(vertical: 8.0),
//                         //     child: Card(
//                         //       elevation: 4,
//                         //       shadowColor: Colors.grey.withOpacity(0.2),
//                         //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//                         //       child: DropdownButtonFormField<MandalData>(
//                         //         isExpanded: true,
//                         //         decoration: InputDecoration(
//                         //           labelText: 'Select Mandal',
//                         //           labelStyle: TextStyle(color: AppColors.secondary.withOpacity(0.8)),
//                         //           filled: true,
//                         //           fillColor: Colors.white,
//                         //           border: OutlineInputBorder(
//                         //             borderRadius: BorderRadius.circular(16),
//                         //             borderSide: BorderSide.none,
//                         //           ),
//                         //           prefixIcon: Icon(Icons.map_outlined, color: AppColors.secondary),
//                         //           contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//                         //         ),
//                         //         value: controller.selectedMandal.value,
//                         //         items: mandals.map((mandal) {
//                         //           return DropdownMenuItem<MandalData>(
//                         //             value: mandal,
//                         //             child: Text(mandal.mandalName),
//                         //           );
//                         //         }).toList(),
//                         //         onChanged: (value) async {
//                         //           controller.selectedMandal.value = value;
//                         //           controller.selectedVillage.value = null;
//                         //           controller.villageController.clearVillages();
//                         //           if (value != null && controller.selectedState.value != null && controller.selectedDistrict.value != null) {
//                         //             await controller.villageController.fetchVillages(
//                         //               stateId: controller.selectedState.value!.id!,
//                         //               districtId: controller.selectedDistrict.value!.id!,
//                         //               mandalId: value.id!,
//                         //             );
//                         //           }
//                         //         },
//                         //         validator: (value) => value == null ? 'Please select a Mandals' : null,
//                         //       ),
//                         //     ),
//                         //   );
//                         // }),
//                         // Obx(() {
//                         //   final selectedMandal = controller.selectedMandal.value;
//                         //   final villages = controller.villageController.villageList;
//                         //   final isVillageLoading = controller.villageController.isLoading.value;
//                         //   if (selectedMandal == null || (!isVillageLoading && villages.isEmpty)) return const SizedBox();
//                         //   if (isVillageLoading) return const Center(child: CircularProgressIndicator(color: AppColors.secondary));
//                         //   return Padding(
//                         //     padding: const EdgeInsets.symmetric(vertical: 8.0),
//                         //     child: Card(
//                         //       elevation: 4,
//                         //       shadowColor: Colors.grey.withOpacity(0.2),
//                         //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//                         //       child: DropdownButtonFormField<VillageData>(
//                         //         isExpanded: true,
//                         //         decoration: InputDecoration(
//                         //           labelText: 'Select Village',
//                         //           labelStyle: TextStyle(color: AppColors.secondary.withOpacity(0.8)),
//                         //           filled: true,
//                         //           fillColor: Colors.white,
//                         //           border: OutlineInputBorder(
//                         //             borderRadius: BorderRadius.circular(16),
//                         //             borderSide: BorderSide.none,
//                         //           ),
//                         //           prefixIcon: Icon(Icons.home_outlined, color: AppColors.secondary),
//                         //           contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//                         //         ),
//                         //         value: controller.selectedVillage.value,
//                         //         items: villages.map((village) {
//                         //           return DropdownMenuItem<VillageData>(
//                         //             value: village,
//                         //             child: Text(village.villageName),
//                         //           );
//                         //         }).toList(),
//                         //         onChanged: (value) {
//                         //           controller.selectedVillage.value = value;
//                         //         },
//                         //         validator: (value) => value == null ? 'Please select a village' : null,
//                         //       ),
//                         //     ),
//                         //   );
//                         // }),
//
//                         Obx(() {
//                           final selectedDistrict = controller.selectedDistrict.value;
//                           final mandals = controller.mandalController.mandalList;
//                           final isMandalLoading = controller.mandalController.isLoading.value;
//
//                           if (selectedDistrict == null || (!isMandalLoading && mandals.isEmpty)) return const SizedBox();
//                           if (isMandalLoading) return const Center(child: CircularProgressIndicator(color: AppColors.secondary));
//
//                           return Padding(
//                             padding: const EdgeInsets.symmetric(vertical: 8.0),
//                             child: Card(
//                               elevation: 4,
//                               shadowColor: Colors.grey.withOpacity(0.2),
//                               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//                               child: DropdownSearch<MandalData>(
//                                 items: mandals,
//                                 selectedItem: controller.selectedMandal.value,
//                                 itemAsString: (MandalData mandal) => mandal.mandalName,
//                                 popupProps: PopupProps.menu(
//                                   showSearchBox: true,
//                                   searchFieldProps: TextFieldProps(
//                                     decoration: InputDecoration(
//                                       hintText: 'Search mandals...',
//                                       prefixIcon: Icon(Icons.search),
//                                       border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
//                                     ),
//                                   ),
//                                 ),
//                                 dropdownDecoratorProps: DropDownDecoratorProps(
//                                   dropdownSearchDecoration: InputDecoration(
//                                     labelText: 'Select Mandal',
//                                     labelStyle: TextStyle(color: AppColors.secondary.withOpacity(0.8)),
//                                     filled: true,
//                                     fillColor: Colors.white,
//                                     border: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(16),
//                                       borderSide: BorderSide.none,
//                                     ),
//                                     prefixIcon: Icon(Icons.map_outlined, color: AppColors.secondary),
//                                     contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//                                   ),
//                                 ),
//                                 onChanged: (value) async {
//                                   controller.selectedMandal.value = value;
//                                   controller.selectedVillage.value = null;
//                                   controller.villageController.clearVillages();
//                                   if (value != null &&
//                                       controller.selectedState.value != null &&
//                                       controller.selectedDistrict.value != null) {
//                                     await controller.villageController.fetchVillages(
//                                       stateId: controller.selectedState.value!.id!,
//                                       districtId: controller.selectedDistrict.value!.id!,
//                                       mandalId: value.id!,
//                                     );
//                                   }
//                                 },
//                                 validator: (value) => value == null ? 'Please select a mandal' : null,
//                               ),
//                             ),
//                           );
//                         }),
//
//                         Obx(() {
//                           final selectedMandal = controller.selectedMandal.value;
//                           final villages = controller.villageController.villageList;
//                           final isVillageLoading = controller.villageController.isLoading.value;
//
//                           if (selectedMandal == null || (!isVillageLoading && villages.isEmpty)) return const SizedBox();
//                           if (isVillageLoading) return const Center(child: CircularProgressIndicator(color: AppColors.secondary));
//
//                           return Padding(
//                             padding: const EdgeInsets.symmetric(vertical: 8.0),
//                             child: Card(
//                               elevation: 4,
//                               shadowColor: Colors.grey.withOpacity(0.2),
//                               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//                               child: DropdownSearch<VillageData>(
//                                 items: villages,
//                                 selectedItem: controller.selectedVillage.value,
//                                 itemAsString: (VillageData village) => village.villageName,
//                                 popupProps: PopupProps.menu(
//                                   showSearchBox: true,
//                                   searchFieldProps: TextFieldProps(
//                                     decoration: InputDecoration(
//                                       hintText: 'Search villages...',
//                                       prefixIcon: Icon(Icons.search),
//                                       border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
//                                     ),
//                                   ),
//                                 ),
//                                 dropdownDecoratorProps: DropDownDecoratorProps(
//                                   dropdownSearchDecoration: InputDecoration(
//                                     labelText: 'Select Village',
//                                     labelStyle: TextStyle(color: AppColors.secondary.withOpacity(0.8)),
//                                     filled: true,
//                                     fillColor: Colors.white,
//                                     border: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(16),
//                                       borderSide: BorderSide.none,
//                                     ),
//                                     prefixIcon: Icon(Icons.home_outlined, color: AppColors.secondary),
//                                     contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//                                   ),
//                                 ),
//                                 onChanged: (value) {
//                                   controller.selectedVillage.value = value;
//                                 },
//                                 validator: (value) => value == null ? 'Please select a village' : null,
//                               ),
//                             ),
//                           );
//                         }),
//
//
//
//                         _buildTextField(
//                           controller: controller.streetNameController,
//                           label: 'Street Name (selected Mandals and villages first)',
//                         ),
//
//                         _buildTextField(
//                           controller: controller.pinCodeController,
//                           label: 'Pin Code',
//                           keyboardType: TextInputType.number,
//                           validator: (val) => val!.isEmpty ? 'Required' : null,
//                           onChanged: () {
//                             if (controller.pinCodeController.text.length == 6) {
//                               controller.fetchCoordinatesFromPincode(controller.pinCodeController.text);
//                             }
//                           },
//                         ),
//
//                       ],
//                     ),
//                   );
//                   break;
//                 case 2:
//                   currentFormKey = formKey3;
//                   buttonText = 'Preview';
//
//                   onButtonPressed = () {
//                     if (formKey3.currentState!.validate()) {
//                       showPropertyPriceDialog(context, propertyPriceController);
//                     }
//                   };
//
//                   content = Form(
//                     key: formKey3,
//                     child: ListView(
//                       padding: const EdgeInsets.all(16),
//                       children: [
//                         const Padding(
//                           padding: EdgeInsets.only(bottom: 16.0),
//                           child: Text(
//                             'Floor Plan Details',
//                             style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.primary),
//                           ),
//                         ),
//                         _buildTextField(
//                           controller: controller.floorPlanTitleController,
//                           label: 'Floor Plan Title',
//                           validator: (val) => val!.isEmpty ? 'Required' : null,
//                         ),
//
//                         _buildTextField(
//                           controller: controller.floorPlanAreaController,
//                           label: 'Floor Plan Area',
//                         ),
//                         _buildTextField(
//                           controller: controller.floorPlanDescriptionController,
//                           label: 'Floor Plan Description',
//                           maxLines: 4,
//                         ),
//                       ],
//                     ),
//                   );
//                   break;
//                 default:
//                   content = const SizedBox();
//                   currentFormKey = GlobalKey<FormState>();
//                   buttonText = '';
//                   onButtonPressed = null;
//               }
//
//               return content;
//             }),
//           ),
//         ],
//       ),
//
//       // bottomNavigationBar: Obx(() => Padding(
//       //   padding: const EdgeInsets.all(16.0),
//       //   child: ElevatedButton(
//       //     onPressed: onButtonPressed,
//       //     style: ElevatedButton.styleFrom(
//       //       backgroundColor: AppColors.secondary,
//       //       padding: const EdgeInsets.symmetric(vertical: 16),
//       //       shape: RoundedRectangleBorder(
//       //         borderRadius: BorderRadius.circular(16),
//       //       ),
//       //     ),
//       //     child: Text(
//       //       controller.currentStep.value == 2 ? 'Preview' : 'Next',
//       //       style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
//       //     ),
//       //   ),
//       // )),
//
//       //   bottomNavigationBar: Obx(() => Padding(
//       //   padding: const EdgeInsets.all(16.0),
//       //   child: ElevatedButton(
//       //     onPressed: () {
//       //       switch (controller.currentStep.value) {
//       //         case 0:
//       //           if (formKey1.currentState!.validate()) {
//       //             if (controller.propertyForController.text.isEmpty) {
//       //               Get.snackbar('Error', 'Property for is required', backgroundColor: Colors.red, colorText: Colors.white);
//       //               return;
//       //             }
//       //             if (controller.propertyCategoryController.text.isEmpty) {
//       //               Get.snackbar('Error', 'Property category is required', backgroundColor: Colors.red, colorText: Colors.white);
//       //               return;
//       //             }
//       //             if (controller.propertyStatusController.text.isEmpty) {
//       //               Get.snackbar('Error', 'Property status is required', backgroundColor: Colors.red, colorText: Colors.white);
//       //               return;
//       //             }
//       //             if (controller.selectedCategory.value != null) {
//       //               final categoryTitle = controller.selectedCategory.value!.propertyCategoryTitle;
//       //               if (categoryTitle == 'Apartment' &&
//       //                   (controller.totalAreaController.text.isEmpty ||
//       //                       controller.builtupAreaController.text.isEmpty ||
//       //                       controller.bedroomsController.text.isEmpty ||
//       //                       controller.bathroomsController.text.isEmpty ||
//       //                       controller.parkingController.text.isEmpty)) {
//       //                 Get.snackbar('Error', 'All apartment details are required', backgroundColor: Colors.red, colorText: Colors.white);
//       //                 return;
//       //               } else if (categoryTitle == 'Villa' &&
//       //                   (controller.villaBuiltupAreaController.text.isEmpty ||
//       //                       controller.villaFloorsController.text.isEmpty ||
//       //                       controller.villaGardenController.text.isEmpty)) {
//       //                 Get.snackbar('Error', 'All villa details are required', backgroundColor: Colors.red, colorText: Colors.white);
//       //                 return;
//       //               } else if (categoryTitle == 'Plot' &&
//       //                   (controller.plotAreaController.text.isEmpty ||
//       //                       controller.plotLengthController.text.isEmpty ||
//       //                       controller.plotWidthController.text.isEmpty ||
//       //                       controller.facingDirectionController.text.isEmpty)) {
//       //                 Get.snackbar('Error', 'All plot details are required', backgroundColor: Colors.red, colorText: Colors.white);
//       //                 return;
//       //               } else if (categoryTitle == 'Commercial Space' &&
//       //                   (controller.commercialAreaController.text.isEmpty ||
//       //                       controller.floorLevelController.text.isEmpty ||
//       //                       controller.suitableForController.text.isEmpty)) {
//       //                 Get.snackbar('Error', 'All commercial space details are required', backgroundColor: Colors.red, colorText: Colors.white);
//       //                 return;
//       //               }
//       //             }
//       //             controller.currentStep.value = 1;
//       //           }
//       //           break;
//       //         case 1:
//       //           if (formKey2.currentState!.validate()) {
//       //             if (controller.selectedState.value == null) {
//       //               Get.snackbar('Error', 'Please select a state', backgroundColor: Colors.red, colorText: Colors.white);
//       //               return;
//       //             }
//       //             if (controller.selectedDistrict.value == null) {
//       //               Get.snackbar('Error', 'Please select a district', backgroundColor: Colors.red, colorText: Colors.white);
//       //               return;
//       //             }
//       //             if (controller.selectedMandal.value == null) {
//       //               Get.snackbar('Error', 'Please select a mandal', backgroundColor: Colors.red, colorText: Colors.white);
//       //               return;
//       //             }
//       //             if (controller.selectedVillage.value == null) {
//       //               Get.snackbar('Error', 'Please select a village', backgroundColor: Colors.red, colorText: Colors.white);
//       //               return;
//       //             }
//       //             if (controller.pinCodeController.text.isEmpty) {
//       //               Get.snackbar('Error', 'Pin code is required', backgroundColor: Colors.red, colorText: Colors.white);
//       //               return;
//       //             }
//       //             controller.currentStep.value = 2;
//       //           }
//       //           break;
//       //         case 2:
//       //           if (formKey3.currentState!.validate()) {
//       //             showPropertyPriceDialog(context, PropertyPriceController());
//       //           }
//       //           break;
//       //       }
//       //     },
//       //     style: ElevatedButton.styleFrom(
//       //       backgroundColor: AppColors.secondary,
//       //       padding: const EdgeInsets.symmetric(vertical: 16),
//       //       shape: RoundedRectangleBorder(
//       //         borderRadius: BorderRadius.circular(16),
//       //       ),
//       //     ),
//       //     child: Text(
//       //       controller.currentStep.value == 2 ? 'Preview' : 'Next',
//       //       style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
//       //     ),
//       //   ),
//       // )),
//
//       bottomNavigationBar: Obx(() => Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: ElevatedButton(
//           onPressed: () {
//             switch (controller.currentStep.value) {
//               case 0:
//                 if (formKey1.currentState!.validate()) {
//                   // Sync dropdowns to controllers
//                   controller._syncPropertyForController();
//                   controller._syncCategoryController();
//                   controller._syncPropertyStatusController();
//
//                   // Validate dropdown selections
//                   if (controller.selectedPropertyFor.value == null || controller.propertyForController.text.isEmpty) {
//                     Get.snackbar('Error', 'Property for is required', backgroundColor: Colors.red, colorText: Colors.white);
//                     return;
//                   }
//                   if (controller.selectedCategory.value == null || controller.propertyCategoryController.text.isEmpty) {
//                     Get.snackbar('Error', 'Property category is required', backgroundColor: Colors.red, colorText: Colors.white);
//                     return;
//                   }
//                   if (controller.selectedPropertyStatus.value == null || controller.propertyStatusController.text.isEmpty) {
//                     Get.snackbar('Error', 'Property status is required', backgroundColor: Colors.red, colorText: Colors.white);
//                     return;
//                   }
//
//                   // Validate category-specific fields
//                   if (controller.selectedCategory.value != null) {
//                     final categoryTitle = controller.selectedCategory.value!.propertyCategoryTitle;
//                     if (categoryTitle == 'Apartment' &&
//                         (controller.totalAreaController.text.isEmpty ||
//                             controller.builtupAreaController.text.isEmpty ||
//                             controller.bedroomsController.text.isEmpty ||
//                             controller.bathroomsController.text.isEmpty ||
//                             controller.parkingController.text.isEmpty)) {
//                       Get.snackbar('Error', 'All apartment details are required', backgroundColor: Colors.red, colorText: Colors.white);
//                       return;
//                     } else if (categoryTitle == 'Villa' &&
//                         (controller.villaBuiltupAreaController.text.isEmpty ||
//                             controller.villaFloorsController.text.isEmpty ||
//                             controller.villaGardenController.text.isEmpty)) {
//                       Get.snackbar('Error', 'All villa details are required', backgroundColor: Colors.red, colorText: Colors.white);
//                       return;
//                     } else if (categoryTitle == 'Plot' &&
//                         (controller.plotAreaController.text.isEmpty ||
//                             controller.plotLengthController.text.isEmpty ||
//                             controller.plotWidthController.text.isEmpty ||
//                             controller.facingDirectionController.text.isEmpty)) {
//                       Get.snackbar('Error', 'All plot details are required', backgroundColor: Colors.red, colorText: Colors.white);
//                       return;
//                     } else if (categoryTitle == 'Commercial Space' &&
//                         (controller.commercialAreaController.text.isEmpty ||
//                             controller.floorLevelController.text.isEmpty ||
//                             controller.suitableForController.text.isEmpty)) {
//                       Get.snackbar('Error', 'All commercial space details are required', backgroundColor: Colors.red, colorText: Colors.white);
//                       return;
//                     }
//                   }
//                   controller.currentStep.value = 1;
//                 }
//                 break;
//               case 1:
//                 if (formKey2.currentState!.validate()) {
//                   if (controller.selectedState.value == null) {
//                     Get.snackbar('Error', 'Please select a state', backgroundColor: Colors.red, colorText: Colors.white);
//                     return;
//                   }
//                   if (controller.selectedDistrict.value == null) {
//                     Get.snackbar('Error', 'Please select a district', backgroundColor: Colors.red, colorText: Colors.white);
//                     return;
//                   }
//                   if (controller.selectedMandal.value == null) {
//                     Get.snackbar('Error', 'Please select a mandal', backgroundColor: Colors.red, colorText: Colors.white);
//                     return;
//                   }
//                   if (controller.selectedVillage.value == null) {
//                     Get.snackbar('Error', 'Please select a village', backgroundColor: Colors.red, colorText: Colors.white);
//                     return;
//                   }
//                   if (controller.pinCodeController.text.isEmpty) {
//                     Get.snackbar('Error', 'Pin code is required', backgroundColor: Colors.red, colorText: Colors.white);
//                     return;
//                   }
//                   controller.currentStep.value = 2;
//                 }
//                 break;
//               case 2:
//                 if (formKey3.currentState!.validate()) {
//                   showPropertyPriceDialog(context, PropertyPriceController());
//                 }
//                 break;
//             }
//           },
//           style: ElevatedButton.styleFrom(
//             backgroundColor: AppColors.secondary,
//             padding: const EdgeInsets.symmetric(vertical: 16),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(16),
//             ),
//           ),
//           child: Text(
//             controller.currentStep.value == 2 ? 'Preview' : 'Next',
//             style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
//           ),
//         ),
//       )),
//     );
//   }
//
//   Widget _buildStep(String title, bool isActive, IconData icon) {
//     return Column(
//       children: [
//         Container(
//           width: 48,
//           height: 48,
//           decoration: BoxDecoration(
//             color: isActive ? AppColors.secondary : AppColors.primary.withOpacity(0.3),
//             shape: BoxShape.circle,
//             border: Border.all(color: Colors.white, width: 2),
//           ),
//           child: Icon(icon, color: isActive ? AppColors.primary : Colors.white, size: 24),
//         ),
//         const SizedBox(height: 8),
//         Text(
//           title,
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 12,
//             fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
//           ),
//           textAlign: TextAlign.center,
//         ),
//       ],
//     );
//   }
//
//   void showPropertyPriceDialog(BuildContext context, PropertyPriceController propertyPriceController) {
//     showDialog(
//       context: context,
//       builder: (context) => SizedBox(
//         width: 200,
//         child: FutureBuilder<PropertyPricePerDay?>(
//           future: propertyPriceController.fetchPropertyPrices(),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return AlertDialog(
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//                 content: const Center(child: CircularProgressIndicator(color: AppColors.secondary)),
//               );
//             }
//             if (snapshot.hasError || snapshot.data == null || snapshot.data!.data == null) {
//               return AlertDialog(
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//                 title: const Text('Error', style: TextStyle(color: AppColors.primary)),
//                 content: const Text('Failed to load property prices'),
//                 actions: [
//                   TextButton(
//                     onPressed: () => Get.back(),
//                     child: const Text('OK', style: TextStyle(color: AppColors.secondary)),
//                   ),
//                 ],
//               );
//             }
//             final prices = snapshot.data!.data!;
//
//
//             return AlertDialog(
//               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//               title: const Text('Property Prices Per Day', style: TextStyle(color: AppColors.primary)),
//               content: SizedBox(
//                 width: double.minPositive,
//                 child: ListView.builder(
//                   shrinkWrap: true,
//                   itemCount: prices.length,
//                   itemBuilder: (context, index) {
//                     final p = prices[index];
//                     return Card(
//                       elevation: 2,
//                       margin: const EdgeInsets.symmetric(vertical: 4),
//                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                       child: ListTile(
//                         title: Text('Charge: ${p.forDayCharge}', style: const TextStyle(fontWeight: FontWeight.bold)),
//                         subtitle: Text('description: ${p.description}', style: const TextStyle(color: Colors.grey)),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//               actions: [
//                 TextButton(
//                   onPressed: () {
//                     Get.back();
//                   },
//                   child: const Text('Cancel', style: TextStyle(color: AppColors.secondary)),
//                 ),
//                 TextButton(
//                   onPressed: () {
//                     Get.back();
//                     Get.to(() => PreviewPropertyScreen());
//                   },
//                   child: const Text('OK', style: TextStyle(color: AppColors.secondary)),
//                 ),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }
// }




class CreateProperty_Screen extends StatelessWidget {
  const CreateProperty_Screen({super.key});

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
    bool readOnly = false,
    int maxLines = 1,
    VoidCallback? onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Card(
        elevation: 4,
        shadowColor: Colors.grey.withOpacity(0.2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: TextFormField(
          controller: controller,
          readOnly: readOnly,
          maxLines: maxLines,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            labelText: label,
            labelStyle: TextStyle(color: AppColors.secondary.withOpacity(0.8)),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            prefixIcon: Icon(Icons.edit, color: AppColors.secondary),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          ),
          validator: validator,
          onChanged: onChanged != null ? (_) => onChanged() : null,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CreatePropertyController());
    final propertyStatusController = Get.put(PropertyStatusController());
    final categoryController = Get.find<CategoryController>();
    final propertyPriceController = PropertyPriceController();
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.primary.withOpacity(0.9),
        title: const Text(
          'List A Property',
          style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 2,
      ),
      body: Obx(() {
        if (categoryController.isLoading.value || controller.isLoading.value || propertyStatusController.isLoading.value) {
          return const Center(child: CircularProgressIndicator(color: AppColors.secondary));
        }

        return Form(
          key: formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Property Details', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.primary)),
                const SizedBox(height: 16),

                _buildTextField(controller: controller.titleController, label: 'Property Title', validator: (val) => val!.isEmpty ? 'Required' : null),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Card(
                    elevation: 4,
                    shadowColor: Colors.grey.withOpacity(0.2),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: 'Property For',
                        labelStyle: TextStyle(color: AppColors.secondary.withOpacity(0.8)),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                        prefixIcon: Icon(Icons.category, color: AppColors.secondary),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      ),
                      value: controller.selectedPropertyFor.value?.isNotEmpty == true ? controller.selectedPropertyFor.value : null,
                      items: ['Sell', 'Rent'].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                      onChanged: (v) {
                        controller.selectedPropertyFor.value = v;
                        controller.propertyForController.text = v ?? '';
                        controller._syncPropertyForController();
                      },
                      validator: (v) => v == null ? 'Please select property for' : null,
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Card(
                    elevation: 4,
                    shadowColor: Colors.grey.withOpacity(0.2),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    child: DropdownButtonFormField<String>(
                      isExpanded: true,
                      decoration: InputDecoration(
                        labelText: 'Property Category',
                        labelStyle: TextStyle(color: AppColors.secondary.withOpacity(0.8)),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                        prefixIcon: Icon(Icons.category, color: AppColors.secondary),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      ),
                      value: controller.propertyCategoryController.text.isNotEmpty ? controller.propertyCategoryController.text : null,
                      items: categoryController.categories
                          .map((c) => DropdownMenuItem(value: c.id, child: Text(c.propertyCategoryTitle)))
                          .toList(),
                      onChanged: (v) {
                        if (v != null) {
                          controller.propertyCategoryController.text = v;
                          final cat = categoryController.categories.firstWhere((e) => e.id == v);
                          controller.updateCategoryData(cat);
                          controller._syncCategoryController();
                        }
                      },
                      validator: (v) => v == null ? 'Please select a category' : null,
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Card(
                    elevation: 4,
                    shadowColor: Colors.grey.withOpacity(0.2),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    child: DropdownButtonFormField<String>(
                      isExpanded: true,
                      decoration: InputDecoration(
                        labelText: 'Property Status',
                        labelStyle: TextStyle(color: AppColors.secondary.withOpacity(0.8)),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                        prefixIcon: Icon(Icons.info, color: AppColors.secondary),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      ),
                      value: controller.selectedPropertyStatus.value?.isNotEmpty == true ? controller.selectedPropertyStatus.value : null,
                      items: propertyStatusController.propertyStatusList
                          .map((s) => DropdownMenuItem(value: s.id, child: Text(s.propertyStatus)))
                          .toList(),
                      onChanged: (v) {
                        controller.selectedPropertyStatus.value = v;
                        controller.propertyStatusController.text = v ?? '';
                        controller._syncPropertyStatusController();
                      },
                      validator: (v) => v == null ? 'Please select a status' : null,
                    ),
                  ),
                ),

                _buildTextField(controller: controller.priceController, label: 'Asking Price', keyboardType: TextInputType.number, validator: (val) => val!.isEmpty ? 'Required' : null),
                _buildTextField(controller: controller.floorPlanDescriptionController, label: 'Description', maxLines: 5),

                Obx(() {
                  final category = controller.selectedCategory.value;
                  if (category == null) return const SizedBox();

                  if (category.propertyCategoryTitle == 'Apartment') {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(padding: EdgeInsets.only(top: 24), child: Text('Apartment Details', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.primary))),
                        _buildTextField(controller: controller.totalAreaController, label: 'Total Area (sq.ft.)', keyboardType: TextInputType.number, validator: (v) => v!.isEmpty ? 'Required' : null),
                        _buildTextField(controller: controller.builtupAreaController, label: 'Built-up Area (sq.ft.)', keyboardType: TextInputType.number, validator: (v) => v!.isEmpty ? 'Required' : null),
                        _buildTextField(controller: controller.bedroomsController, label: 'Number of Bedrooms', keyboardType: TextInputType.number, validator: (v) => v!.isEmpty ? 'Required' : null),
                        _buildTextField(controller: controller.bathroomsController, label: 'Number of Bathrooms', keyboardType: TextInputType.number, validator: (v) => v!.isEmpty ? 'Required' : null),
                        _buildTextField(controller: controller.parkingController, label: 'Parking Availability', validator: (v) => v!.isEmpty ? 'Required' : null),
                      ],
                    );
                  } else if (category.propertyCategoryTitle == 'Villa') {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(padding: EdgeInsets.only(top: 24), child: Text('Villa Details', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.primary))),
                        _buildTextField(controller: controller.villaBuiltupAreaController, label: 'Built-up Area (sq.ft.)', keyboardType: TextInputType.number, validator: (v) => v!.isEmpty ? 'Required' : null),
                        _buildTextField(controller: controller.villaFloorsController, label: 'Number of Floors', keyboardType: TextInputType.number, validator: (v) => v!.isEmpty ? 'Required' : null),
                        _buildTextField(controller: controller.villaGardenController, label: 'Garden Area (sq.ft.)', keyboardType: TextInputType.number, validator: (v) => v!.isEmpty ? 'Required' : null),
                      ],
                    );
                  } else if (category.propertyCategoryTitle == 'Plot') {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(padding: EdgeInsets.only(top: 24), child: Text('Plot Details', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.primary))),
                        _buildTextField(controller: controller.plotAreaController, label: 'Plot Area (sq.ft.)', keyboardType: TextInputType.number, validator: (v) => v!.isEmpty ? 'Required' : null),
                        _buildTextField(controller: controller.plotLengthController, label: 'Plot Length (ft.)', keyboardType: TextInputType.number, validator: (v) => v!.isEmpty ? 'Required' : null),
                        _buildTextField(controller: controller.plotWidthController, label: 'Plot Width (ft.)', keyboardType: TextInputType.number, validator: (v) => v!.isEmpty ? 'Required' : null),
                        _buildTextField(controller: controller.facingDirectionController, label: 'Facing Direction', validator: (v) => v!.isEmpty ? 'Required' : null),
                      ],
                    );
                  } else if (category.propertyCategoryTitle == 'Commercial Space') {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(padding: EdgeInsets.only(top: 24), child: Text('Commercial Space Details', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.primary))),
                        _buildTextField(controller: controller.commercialAreaController, label: 'Commercial Area (sq.ft.)', keyboardType: TextInputType.number, validator: (v) => v!.isEmpty ? 'Required' : null),
                        _buildTextField(controller: controller.floorLevelController, label: 'Floor Level', keyboardType: TextInputType.number, validator: (v) => v!.isEmpty ? 'Required' : null),
                        _buildTextField(controller: controller.suitableForController, label: 'Suitable For', validator: (v) => v!.isEmpty ? 'Required' : null),
                      ],
                    );
                  }
                  return const SizedBox();
                }),
                const SizedBox(height: 5),
                const Text('Location Details', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.primary)),

                Obx(() => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Card(
                    elevation: 4,
                    shadowColor: Colors.grey.withOpacity(0.2),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    child: DropdownSearch<StatesModelData>(
                      items: controller.stateController.statesList,
                      selectedItem: controller.selectedState.value,
                      itemAsString: (s) => s.stateName ?? '',
                      dropdownDecoratorProps: DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          labelText: 'Select State',
                          labelStyle: TextStyle(color: AppColors.secondary.withOpacity(0.8)),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                          prefixIcon: Icon(Icons.flag, color: AppColors.secondary),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                        ),
                      ),
                      popupProps: const PopupProps.menu(showSearchBox: true),
                      onChanged: (v) async {
                        controller.selectedState.value = v;
                        controller.selectedDistrict.value = null;
                        controller.selectedMandal.value = null;
                        controller.selectedVillage.value = null;
                        controller.districtController.clearDistricts();
                        controller.mandalController.clearMandals();
                        controller.villageController.clearVillages();
                        if (v != null) await controller.districtController.fetchDistricts(v.id!);
                      },
                      validator: (v) => v == null ? 'Please select a state' : null,
                    ),
                  ),
                )),

                Obx(() => controller.selectedState.value == null
                    ? const SizedBox()
                    : Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Card(
                    elevation: 4,
                    shadowColor: Colors.grey.withOpacity(0.2),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    child: DropdownSearch<DistrictData>(
                      items: controller.districtController.districtList,
                      selectedItem: controller.selectedDistrict.value,
                      itemAsString: (d) => d.districtName,
                      dropdownDecoratorProps: DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          labelText: 'Select District',
                          labelStyle: TextStyle(color: AppColors.secondary.withOpacity(0.8)),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                          prefixIcon: Icon(Icons.location_city, color: AppColors.secondary),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                        ),
                      ),
                      popupProps: const PopupProps.menu(showSearchBox: true),
                      onChanged: (v) async {
                        controller.selectedDistrict.value = v;
                        controller.selectedMandal.value = null;
                        controller.selectedVillage.value = null;
                        controller.mandalController.clearMandals();
                        controller.villageController.clearVillages();
                        if (v != null && controller.selectedState.value != null) {
                          await controller.mandalController.fetchMandals(
                            stateId: controller.selectedState.value!.id!,
                            districtId: v.id!,
                          );
                        }
                      },
                      validator: (v) => v == null ? 'Please select a district' : null,
                    ),
                  ),
                )),

                Obx(() => controller.selectedDistrict.value == null
                    ? const SizedBox()
                    : Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Card(
                    elevation: 4,
                    shadowColor: Colors.grey.withOpacity(0.2),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    child: DropdownSearch<MandalData>(
                      items: controller.mandalController.mandalList,
                      selectedItem: controller.selectedMandal.value,
                      itemAsString: (m) => m.mandalName,
                      dropdownDecoratorProps: DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          labelText: 'Select Mandal',
                          labelStyle: TextStyle(color: AppColors.secondary.withOpacity(0.8)),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                          prefixIcon: Icon(Icons.map_outlined, color: AppColors.secondary),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                        ),
                      ),
                      popupProps: const PopupProps.menu(showSearchBox: true),
                      onChanged: (v) async {
                        controller.selectedMandal.value = v;
                        controller.selectedVillage.value = null;
                        controller.villageController.clearVillages();
                        if (v != null && controller.selectedState.value != null && controller.selectedDistrict.value != null) {
                          await controller.villageController.fetchVillages(
                            stateId: controller.selectedState.value!.id!,
                            districtId: controller.selectedDistrict.value!.id!,
                            mandalId: v.id!,
                          );
                        }
                      },
                      validator: (v) => v == null ? 'Please select a mandal' : null,
                    ),
                  ),
                )),

                Obx(() => controller.selectedMandal.value == null
                    ? const SizedBox()
                    : Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Card(
                    elevation: 4,
                    shadowColor: Colors.grey.withOpacity(0.2),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    child: DropdownSearch<VillageData>(
                      items: controller.villageController.villageList,
                      selectedItem: controller.selectedVillage.value,
                      itemAsString: (v) => v.villageName,
                      dropdownDecoratorProps: DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          labelText: 'Select Village',
                          labelStyle: TextStyle(color: AppColors.secondary.withOpacity(0.8)),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                          prefixIcon: Icon(Icons.home_outlined, color: AppColors.secondary),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                        ),
                      ),
                      popupProps: const PopupProps.menu(showSearchBox: true),
                      onChanged: (v) => controller.selectedVillage.value = v,
                      validator: (v) => v == null ? 'Please select a village' : null,
                    ),
                  ),
                )),

                _buildTextField(controller: controller.streetNameController, label: 'Street Name'),

                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      controller._syncPropertyForController();
                      controller._syncCategoryController();
                      controller._syncPropertyStatusController();

                      if (!formKey.currentState!.validate()) return;

                      if (controller.selectedPropertyFor.value == null || controller.selectedCategory.value == null || controller.selectedPropertyStatus.value == null) {
                        Get.snackbar('Error', 'Please fill all required fields', backgroundColor: Colors.red, colorText: Colors.white);
                        return;
                      }

                      if (controller.selectedState.value == null || controller.selectedDistrict.value == null || controller.selectedMandal.value == null || controller.selectedVillage.value == null) {
                        Get.snackbar('Error', 'Please complete location selection', backgroundColor: Colors.red, colorText: Colors.white);
                        return;
                      }

                      final cat = controller.selectedCategory.value!.propertyCategoryTitle;
                      if (cat == 'Apartment' && [controller.totalAreaController, controller.builtupAreaController, controller.bedroomsController, controller.bathroomsController, controller.parkingController].any((c) => c.text.isEmpty)) {
                        Get.snackbar('Error', 'All apartment fields are required', backgroundColor: Colors.red, colorText: Colors.white);
                        return;
                      }
                      if (cat == 'Villa' && [controller.villaBuiltupAreaController, controller.villaFloorsController, controller.villaGardenController].any((c) => c.text.isEmpty)) {
                        Get.snackbar('Error', 'All villa fields are required', backgroundColor: Colors.red, colorText: Colors.white);
                        return;
                      }
                      if (cat == 'Plot' && [controller.plotAreaController, controller.plotLengthController, controller.plotWidthController, controller.facingDirectionController].any((c) => c.text.isEmpty)) {
                        Get.snackbar('Error', 'All plot fields are required', backgroundColor: Colors.red, colorText: Colors.white);
                        return;
                      }
                      if (cat == 'Commercial Space' && [controller.commercialAreaController, controller.floorLevelController, controller.suitableForController].any((c) => c.text.isEmpty)) {
                        Get.snackbar('Error', 'All commercial fields are required', backgroundColor: Colors.red, colorText: Colors.white);
                        return;
                      }

                      // Submit property but don't clear form until payment is complete
                      final success = await controller.submitProperty(formKey);
                      if (success) {
                        showPropertyPriceDialog(context, propertyPriceController);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.secondary,
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      elevation: 6,
                    ),
                    child: const Text('Preview', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        );
      }),
    );
  }
}

void showPropertyPriceDialog(BuildContext context, PropertyPriceController propertyPriceController) {
  showDialog(
    context: context,
    builder: (context) => SizedBox(
      width: 200,
      child: FutureBuilder<PropertyPricePerDay?>(
        future: propertyPriceController.fetchPropertyPrices(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              content: const Center(child: CircularProgressIndicator(color: AppColors.secondary)),
            );
          }
          if (snapshot.hasError || snapshot.data == null || snapshot.data!.data == null) {
            return AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              title: const Text('Error', style: TextStyle(color: AppColors.primary)),
              content: const Text('Failed to load property prices'),
              actions: [
                TextButton(
                  onPressed: () => Get.back(),
                  child: const Text('OK', style: TextStyle(color: AppColors.secondary)),
                ),
              ],
            );
          }
          final prices = snapshot.data!.data!;

          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            backgroundColor: Colors.white,
            elevation: 8,
            title: const Text(
              'Property Prices Per Day',
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 20,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
            content: SizedBox(
              width: double.maxFinite,
              child: ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: prices.length,
                itemBuilder: (context, index) {
                  final p = prices[index];
                  return Card(
                    elevation: 3,
                    margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    color: Colors.grey[50],
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      title: Text(
                        'List your property for \ ${p.forDayCharge} per day',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                        ),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          'description: ${p.description}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                            height: 1.4,
                          ),
                        ),
                      ),
                      // trailing: Icon(
                      //   Icons.arrow_forward_ios,
                      //   size: 16,
                      //   color: AppColors.primary,
                      // ),
                      // onTap: () {
                      //
                      // },
                    ),
                  );
                },
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Get.back();
                },
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  backgroundColor: Colors.grey[200], // Subtle background for cancel
                ),
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                    color: AppColors.secondary,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Get.back();
                  Get.to(() => PreviewPropertyScreen());
                },
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  backgroundColor: AppColors.primary, // Prominent primary color for OK
                ),
                child: const Text(
                  'OK',
                  style: TextStyle(
                    color: Colors.white, // White text for contrast
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
            actionsPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), // Consistent padding
          );
        },
      ),
    ),
  );
}

//         Preview Property screen with payment

class PreviewPropertyScreen extends StatefulWidget {
  PreviewPropertyScreen({super.key});

  @override
  _PreviewPropertyScreenState createState() => _PreviewPropertyScreenState();
}

class _PreviewPropertyScreenState extends State<PreviewPropertyScreen> {
  late Razorpay _razorpay;
  String? _selectedPlanId; // Store selected plan ID

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    final controller = Get.find<CreatePropertyController>();

    print('========== RAZORPAY PAYMENT SUCCESS ==========');
    print('   Complete Payment Response:');
    print('   Payment ID: ${response.paymentId}');
    print('   Order ID: ${response.orderId}');
    print('   Signature: ${response.signature}');
    print('=============================================');

    // Now we have all three parameters as per documentation
    String? razorpayPaymentId = response.paymentId;
    String? razorpayOrderId = response.orderId;
    String? razorpaySignature = response.signature;

    // Validate all required parameters
    if (razorpayPaymentId == null || razorpayOrderId == null || razorpaySignature == null) {
      _handleVerificationFailed('Missing payment details from Razorpay response');
      return;
    }

    // Use the stored plan ID
    if (_selectedPlanId == null || _selectedPlanId!.isEmpty) {
      _handleVerificationFailed('Plan ID not found. Please try the payment again.');
      return;
    }

    print(' Using Plan ID: $_selectedPlanId');

    Fluttertoast.showToast(
      msg: "Payment Successful!",
      backgroundColor: Colors.green,
      textColor: Colors.white,
    );
    // Send to backend with all three parameters and dynamic plan_id
    await _sendPaymentToBackend(
      razorpayOrderId: razorpayOrderId,
      razorpayPaymentId: razorpayPaymentId,
      razorpaySignature: razorpaySignature,
      planId: _selectedPlanId!, // Use the stored plan ID
      controller: controller,
    );
  }
  Future<void> _sendPaymentToBackend({
    required String razorpayOrderId,
    required String razorpayPaymentId,
    required String razorpaySignature,
    required String planId,
    required CreatePropertyController controller,
  }) async {
    try {
      Get.dialog(const Center(child: CircularProgressIndicator()), barrierDismissible: false);
      print(' Sending payment verification to backend...');

      var request = http.MultipartRequest(
        'POST',
        Uri.parse(EndPoint.processPayment),
      );

      request.fields.addAll({
        'razorpay_order_id': razorpayOrderId,
        'razorpay_payment_id': razorpayPaymentId,
        'razorpay_signature': razorpaySignature,
        'customer_id': controller.userId ?? '',
        'plan_id': planId,
        'property_id': controller.propertyId.value ?? '',
        'test_mode': '1',
      });

      final streamedResponse = await request.send().timeout(const Duration(seconds: 30));
      final responseBody = await streamedResponse.stream.bytesToString();

      Get.back(); // Close loading

      if (streamedResponse.statusCode == 200 || streamedResponse.statusCode == 201) {
        final jsonResponse = json.decode(responseBody);

        if (jsonResponse['status'] == true) {
          print(' Payment verification SUCCESSFUL');

          // ONLY clear form after successful payment
          controller.clearFormAfterSuccessfulPayment();

          Get.snackbar(
            'Success!',
            jsonResponse['message'] ?? 'Payment processed successfully!',
            backgroundColor: Colors.green,
            colorText: Colors.white,
            duration: const Duration(seconds: 4),
          );

          Get.offAllNamed('/home');
        } else {
          print(' Backend verification failed');
          _handleVerificationFailed('Payment verification failed: ${jsonResponse['message']}');
        }
      } else {
        print(' Backend server error');
        _handleVerificationFailed('Server error: ${streamedResponse.statusCode}');
      }

    } catch (e) {
      Get.back();
      print(' Backend call failed: $e');
      _handleVerificationFailed('Network error: $e');
    }
  }

  void _handleVerificationFailed(String message) {
    Get.snackbar(
      'Payment Failed',
      'Verification failed. Please try again.',
      backgroundColor: Colors.red,
      colorText: Colors.white,
      duration: const Duration(seconds: 10),
    );

    Get.dialog(
      AlertDialog(
        title: const Text('Payment Issue'),
        content: SelectableText(message),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Close')),
          TextButton(
            onPressed: () {
              Get.back();
              showPlansDialog(context);
            },
            child: const Text('Retry Payment'),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(msg: "Payment Failed: ${response.message}");
    Get.snackbar('Error', 'Payment failed: ${response.message}', backgroundColor: Colors.red, colorText: Colors.white);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(msg: "External Wallet: ${response.walletName}");
    Get.snackbar('Info', 'External wallet selected: ${response.walletName}', backgroundColor: Colors.blue, colorText: Colors.white);
  }

  // Method to create order before payment
  Future<String?> createOrder(String amount) async {
    try {
      print(' Creating Razorpay Order...');
      print('   Amount: $amount paise (${int.parse(amount) / 100} INR)');

      final String apiKey = '${EndPoint.razorpayApiKey}';
      final String apiSecret = '${EndPoint.razorpayKeySecret}';

      final String basicAuth = 'Basic ${base64Encode(utf8.encode('$apiKey:$apiSecret'))}';

      var request = {
        'amount': amount, // amount in paise
        'currency': 'INR',
        'receipt': 'rcpt_${DateTime.now().millisecondsSinceEpoch}',
        'payment_capture': 1
      };

      final response = await http.post(
        Uri.parse('https://api.razorpay.com/v1/orders'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': basicAuth,
        },
        body: json.encode(request),
      ).timeout(const Duration(seconds: 30));

      print('   Razorpay Order API Response:');
      print('   Status Code: ${response.statusCode}');
      print('   Response: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final String orderId = responseData['id'];
        print(' Order Created Successfully: $orderId');
        return orderId;
      } else {
        print('   Order Creation Failed: ${response.statusCode}');
        print('   Error: ${response.body}');
        return null;
      }
    } catch (e) {
      print(' Order Creation Exception: $e');
      return null;
    }
  }

  Future<void> _startRazorpayWithOrder(String amount, String planId) async {
    final controller = Get.find<CreatePropertyController>();

    try {
      Get.dialog(const Center(child: CircularProgressIndicator()), barrierDismissible: false);

      // Fix the amount calculation
      final String amountInPaise = ((double.tryParse(amount) ?? 0) * 100).toStringAsFixed(0);
      final String? orderId = await createOrder(amountInPaise);

      if (orderId == null) {
        Get.back();
        Get.snackbar(
          'Error',
          'Failed to create order. Please try again.',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }

      Get.back(); // Close loading

      print(' Proceeding with Order ID: $orderId');
      print(' Selected Plan ID: $planId');

      // Prepare options for Razorpay checkout
      var options = {
        'key': '${EndPoint.razorpayApiKey}',
        'amount': amountInPaise,
        'name': controller.username ?? 'Customer',
        'description': 'Property Plan Payment - Plan ID: $planId',
        'order_id': orderId,
        'prefill': {
          'contact': controller.mobileNumber ?? '9123456789',
          'email': controller.email ?? 'customer@email.com',
        },
        'timeout': 300,
        'notes': {
          'plan_id': planId,
          'property_id': controller.propertyId.value ?? '',
          'customer_id': controller.userId ?? '',
        },
      };

      print(' Opening Razorpay Checkout...');
      print('   Options: $options');

      _razorpay.open(options);

    } catch (e) {
      Get.back();
      print(' Razorpay Payment Error: $e');
      Get.snackbar(
        'Error',
        'Payment initialization failed: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
  final controller = Get.find<CreatePropertyController>();
  final propertyStatusController = Get.find<PropertyStatusController>();
  final categoryController = Get.find<CategoryController>();
  final propertyPlanController = Get.find<PropertyPlanController>();
  final customerPlanController = Get.find<CustomerPlanController>();
  final formKey = GlobalKey<FormState>();
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
    bool readOnly = false,
    int maxLines = 1,
    VoidCallback? onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Card(
        elevation: 4,
        shadowColor: Colors.grey.withOpacity(0.2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: TextFormField(
          controller: controller,
          readOnly: readOnly,
          maxLines: maxLines,
          decoration: InputDecoration(
            labelText: label,
            labelStyle: TextStyle(color: AppColors.secondary.withOpacity(0.8)),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            prefixIcon: Icon(Icons.edit, color: AppColors.secondary),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          keyboardType: keyboardType,
          validator: validator,
          onChanged: onChanged != null ? (value) => onChanged() : null,
          onSaved: (value) {
            if (value != null) controller.text = value;
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary.withOpacity(0.9),
        title: const Text(
          'Preview & Edit Property',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Property Details',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.primary),
              ),
              const SizedBox(height: 8),
              _buildTextField(
                controller: controller.titleController,
                label: 'Property Title',
                validator: (val) => val!.isEmpty ? 'Required' : null,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Card(
                  elevation: 4,
                  shadowColor: Colors.grey.withOpacity(0.2),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'Property For',
                      labelStyle: TextStyle(color: AppColors.secondary.withOpacity(0.8)),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: Icon(Icons.category, color: AppColors.secondary),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                    value: controller.propertyForController.text.isEmpty ||
                        !['Sell', 'Rent'].contains(controller.propertyForController.text)
                        ? null
                        : controller.propertyForController.text,
                    items: ['Sell', 'Rent'].map((propertyFor) {
                      return DropdownMenuItem<String>(
                        value: propertyFor,
                        child: Text(propertyFor),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      if (newValue != null) {
                        controller.propertyForController.text = newValue;
                      }
                    },
                    validator: (val) => val == null || val.isEmpty ? 'Please select property for' : null,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Card(
                  elevation: 4,
                  shadowColor: Colors.grey.withOpacity(0.2),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  child: DropdownButtonFormField<String>(
                    isExpanded: true,
                    decoration: InputDecoration(
                      labelText: 'Property Category',
                      labelStyle: TextStyle(color: AppColors.secondary.withOpacity(0.8)),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: Icon(Icons.category, color: AppColors.secondary),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                    value: controller.propertyCategoryController.text.isEmpty
                        ? null
                        : controller.propertyCategoryController.text,
                    items: categoryController.categories.map((category) {
                      return DropdownMenuItem<String>(
                        value: category.id,
                        child: Text(category.propertyCategoryTitle),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      if (newValue != null) {
                        controller.propertyCategoryController.text = newValue;
                        final selectedCategory = categoryController.categories
                            .firstWhere((cat) => cat.id == newValue);
                        controller.updateCategoryData(selectedCategory);
                      }
                    },
                    validator: (val) => val == null || val.isEmpty ? 'Please select a category' : null,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Card(
                  elevation: 4,
                  shadowColor: Colors.grey.withOpacity(0.2),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  child: DropdownButtonFormField<String>(
                    isExpanded: true,
                    decoration: InputDecoration(
                      labelText: 'Property Status',
                      labelStyle: TextStyle(color: AppColors.secondary.withOpacity(0.8)),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: Icon(Icons.info, color: AppColors.secondary),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                    value: controller.propertyStatusController.text.isEmpty
                        ? null
                        : controller.propertyStatusController.text,
                    items: propertyStatusController.propertyStatusList.map((status) {
                      return DropdownMenuItem<String>(
                        value: status.id,
                        child: Text(status.propertyStatus),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      if (newValue != null) {
                        controller.propertyStatusController.text = newValue;
                      }
                    },
                    validator: (val) => val == null || val.isEmpty ? 'Please select a status' : null,
                  ),
                ),
              ),
              _buildTextField(
                controller: controller.priceController,
                label: 'Listing Price',
                keyboardType: TextInputType.number,
                validator: (val) => val!.isEmpty ? 'Required' : null,
              ),
              _buildTextField(
                controller: controller.floorPlanDescriptionController,
                label: 'Description',
                maxLines: 4,
              ),
              Obx(() {
                final category = controller.selectedCategory.value;
                if (category == null) return const SizedBox();
                if (category.propertyCategoryTitle == 'Apartment') {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        child: Text(
                          'Apartment Details',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.primary),
                        ),
                      ),
                      _buildTextField(
                        controller: controller.totalAreaController,
                        label: 'Total Area (sq.ft.)',
                        keyboardType: TextInputType.number,
                        validator: (val) => val!.isEmpty ? 'Required' : null,
                      ),
                      _buildTextField(
                        controller: controller.builtupAreaController,
                        label: 'Built-up Area (sq.ft.)',
                        keyboardType: TextInputType.number,
                        validator: (val) => val!.isEmpty ? 'Required' : null,
                      ),
                      _buildTextField(
                        controller: controller.bedroomsController,
                        label: 'Number of Bedrooms',
                        keyboardType: TextInputType.number,
                        validator: (val) => val!.isEmpty ? 'Required' : null,
                      ),
                      _buildTextField(
                        controller: controller.bathroomsController,
                        label: 'Number of Bathrooms',
                        keyboardType: TextInputType.number,
                        validator: (val) => val!.isEmpty ? 'Required' : null,
                      ),
                      _buildTextField(
                        controller: controller.parkingController,
                        label: 'Parking Availability',
                        validator: (val) => val!.isEmpty ? 'Required' : null,
                      ),
                    ],
                  );
                } else if (category.propertyCategoryTitle == 'Villa') {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        child: Text(
                          'Villa Details',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.primary),
                        ),
                      ),
                      _buildTextField(
                        controller: controller.villaBuiltupAreaController,
                        label: 'Built-up Area (sq.ft.)',
                        keyboardType: TextInputType.number,
                        validator: (val) => val!.isEmpty ? 'Required' : null,
                      ),
                      _buildTextField(
                        controller: controller.villaFloorsController,
                        label: 'Number of Floors',
                        keyboardType: TextInputType.number,
                        validator: (val) => val!.isEmpty ? 'Required' : null,
                      ),
                      _buildTextField(
                        controller: controller.villaGardenController,
                        label: 'Garden Area (sq.ft.)',
                        keyboardType: TextInputType.number,
                        validator: (val) => val!.isEmpty ? 'Required' : null,
                      ),
                    ],
                  );
                } else if (category.propertyCategoryTitle == 'Plot') {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        child: Text(
                          'Plot Details',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.primary),
                        ),
                      ),
                      _buildTextField(
                        controller: controller.plotAreaController,
                        label: 'Plot Area (sq.ft.)',
                        keyboardType: TextInputType.number,
                        validator: (val) => val!.isEmpty ? 'Required' : null,
                      ),
                      _buildTextField(
                        controller: controller.plotLengthController,
                        label: 'Plot Length (ft.)',
                        keyboardType: TextInputType.number,
                        validator: (val) => val!.isEmpty ? 'Required' : null,
                      ),
                      _buildTextField(
                        controller: controller.plotWidthController,
                        label: 'Plot Width (ft.)',
                        keyboardType: TextInputType.number,
                        validator: (val) => val!.isEmpty ? 'Required' : null,
                      ),
                      _buildTextField(
                        controller: controller.facingDirectionController,
                        label: 'Facing Direction',
                        validator: (val) => val!.isEmpty ? 'Required' : null,
                      ),
                    ],
                  );
                } else if (category.propertyCategoryTitle == 'Commercial Space') {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        child: Text(
                          'Commercial Space Details',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.primary),
                        ),
                      ),
                      _buildTextField(
                        controller: controller.commercialAreaController,
                        label: 'Commercial Area (sq.ft.)',
                        keyboardType: TextInputType.number,
                        validator: (val) => val!.isEmpty ? 'Required' : null,
                      ),
                      _buildTextField(
                        controller: controller.floorLevelController,
                        label: 'Floor Level',
                        keyboardType: TextInputType.number,
                        validator: (val) => val!.isEmpty ? 'Required' : null,
                      ),
                      _buildTextField(
                        controller: controller.suitableForController,
                        label: 'Suitable For',
                        validator: (val) => val!.isEmpty ? 'Required' : null,
                      ),
                    ],
                  );
                }
                return const SizedBox();
              }),
              const SizedBox(height: 16),
              const Text(
                'Location Details',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.primary),
              ),
              const SizedBox(height: 8),
              Obx(() {
                final states = controller.stateController.statesList;
                if (controller.stateController.isLoading.value) {
                  return const Center(child: CircularProgressIndicator(color: AppColors.secondary));
                }
                if (states.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Text('No states available', style: TextStyle(color: Colors.red)),
                  );
                }
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Card(
                    elevation: 4,
                    shadowColor: Colors.grey.withOpacity(0.2),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    child: DropdownButtonFormField<StatesModelData>(
                      isExpanded: true,
                      decoration: InputDecoration(
                        labelText: 'Select State',
                        labelStyle: TextStyle(color: AppColors.secondary.withOpacity(0.8)),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none,
                        ),
                        prefixIcon: Icon(Icons.flag, color: AppColors.secondary),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                      value: controller.selectedState.value,
                      items: states.map((state) {
                        return DropdownMenuItem<StatesModelData>(
                          value: state,
                          child: Text(state.stateName ?? ''),
                        );
                      }).toList(),
                      onChanged: (value) async {
                        controller.selectedState.value = value;
                        controller.selectedDistrict.value = null;
                        controller.selectedMandal.value = null;
                        controller.selectedVillage.value = null;
                        controller.districtController.clearDistricts();
                        controller.mandalController.clearMandals();
                        controller.villageController.clearVillages();
                        if (value != null) {
                          await controller.districtController.fetchDistricts(value.id!);
                        }
                      },
                      validator: (value) => value == null ? 'Please select a state' : null,
                    ),
                  ),
                );
              }),
              Obx(() {
                final selectedState = controller.selectedState.value;
                final districts = controller.districtController.districtList;
                final isDistrictLoading = controller.districtController.isLoading.value;
                if (selectedState == null) return const SizedBox();
                if (isDistrictLoading) return const Center(child: CircularProgressIndicator(color: AppColors.secondary));
                if (districts.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Text('No districts available', style: TextStyle(color: Colors.red)),
                  );
                }
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Card(
                    elevation: 4,
                    shadowColor: Colors.grey.withOpacity(0.2),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    child: DropdownButtonFormField<DistrictData>(
                      isExpanded: true,
                      decoration: InputDecoration(
                        labelText: 'Select District',
                        labelStyle: TextStyle(color: AppColors.secondary.withOpacity(0.8)),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none,
                        ),
                        prefixIcon: Icon(Icons.location_city, color: AppColors.secondary),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                      value: controller.selectedDistrict.value,
                      items: districts.map((district) {
                        return DropdownMenuItem<DistrictData>(
                          value: district,
                          child: Text(district.districtName),
                        );
                      }).toList(),
                      onChanged: (value) async {
                        controller.selectedDistrict.value = value;
                        controller.selectedMandal.value = null;
                        controller.selectedVillage.value = null;
                        controller.mandalController.clearMandals();
                        controller.villageController.clearVillages();
                        if (value != null && controller.selectedState.value != null) {
                          await controller.mandalController.fetchMandals(
                            stateId: controller.selectedState.value!.id!,
                            districtId: value.id!,
                          );
                        }
                      },
                      validator: (value) => value == null ? 'Please select a district' : null,
                    ),
                  ),
                );
              }),
              Obx(() {
                final selectedDistrict = controller.selectedDistrict.value;
                final mandals = controller.mandalController.mandalList;
                final isMandalLoading = controller.mandalController.isLoading.value;
                if (selectedDistrict == null || (!isMandalLoading && mandals.isEmpty)) return const SizedBox();
                if (isMandalLoading) return const Center(child: CircularProgressIndicator(color: AppColors.secondary));
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Card(
                    elevation: 4,
                    shadowColor: Colors.grey.withOpacity(0.2),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    child: DropdownButtonFormField<MandalData>(
                      isExpanded: true,
                      decoration: InputDecoration(
                        labelText: 'Select Mandal',
                        labelStyle: TextStyle(color: AppColors.secondary.withOpacity(0.8)),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none,
                        ),
                        prefixIcon: Icon(Icons.map_outlined, color: AppColors.secondary),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                      value: controller.selectedMandal.value,
                      items: mandals.map((mandal) {
                        return DropdownMenuItem<MandalData>(
                          value: mandal,
                          child: Text(mandal.mandalName),
                        );
                      }).toList(),
                      onChanged: (value) async {
                        controller.selectedMandal.value = value;
                        controller.selectedVillage.value = null;
                        controller.villageController.clearVillages();
                        if (value != null && controller.selectedState.value != null && controller.selectedDistrict.value != null) {
                          await controller.villageController.fetchVillages(
                            stateId: controller.selectedState.value!.id!,
                            districtId: controller.selectedDistrict.value!.id!,
                            mandalId: value.id!,
                          );
                        }
                      },
                      validator: (value) => value == null ? 'Please select a mandal' : null,
                    ),
                  ),
                );
              }),
              Obx(() {
                final selectedMandal = controller.selectedMandal.value;
                final villages = controller.villageController.villageList;
                final isVillageLoading = controller.villageController.isLoading.value;
                if (selectedMandal == null || (!isVillageLoading && villages.isEmpty)) return const SizedBox();
                if (isVillageLoading) return const Center(child: CircularProgressIndicator(color: AppColors.secondary));
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Card(
                    elevation: 4,
                    shadowColor: Colors.grey.withOpacity(0.2),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    child: DropdownButtonFormField<VillageData>(
                      isExpanded: true,
                      decoration: InputDecoration(
                        labelText: 'Select Village',
                        labelStyle: TextStyle(color: AppColors.secondary.withOpacity(0.8)),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none,
                        ),
                        prefixIcon: Icon(Icons.home_outlined, color: AppColors.secondary),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                      value: controller.selectedVillage.value,
                      items: villages.map((village) {
                        return DropdownMenuItem<VillageData>(
                          value: village,
                          child: Text(village.villageName),
                        );
                      }).toList(),
                      onChanged: (value) {
                        controller.selectedVillage.value = value;
                      },
                      validator: (value) => value == null ? 'Please select a village' : null,
                    ),
                  ),
                );
              }),
              _buildTextField(
                controller: controller.streetNameController,
                label: 'Street Name',
              ),
              const SizedBox(height: 32),
              SafeArea(
                child: Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        final success = await controller.submitProperty(formKey);
                        if (success) {
                          showPlansDialog(context);
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.secondary,
                      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text('Submit Property', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showPlansDialog(BuildContext context) {
    final selectedPlanId = RxnString();
    final selectedPlan = Rxn<dynamic>();
    final propertyPlanController = Get.find<PropertyPlanController>();
    final customerPlanController = Get.find<CustomerPlanController>(); // Add this
    showDialog(
      context: context,
      builder: (context) => Obx(() {
        if (propertyPlanController.isLoading.value) {
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            content: Center(child: CircularProgressIndicator(color: AppColors.secondary)),
          );
        }
        final plans = propertyPlanController.planDaysList;
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text('Select Plan', style: TextStyle(color: AppColors.primary)),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: plans.length,
              itemBuilder: (context, index) {
                final plan = plans[index];
                return Obx(() => Card(
                  elevation: 2,
                  margin: EdgeInsets.symmetric(vertical: 4),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: RadioListTile<String>(
                    title: Text('${plan.planDays} days - ₹${plan.totalPrice}',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    //subtitle: Text('Plan ID: ${plan.id}'),
                    value: plan.id!,
                    groupValue: selectedPlanId.value,
                    onChanged: (value) {
                      selectedPlanId.value = value;
                      selectedPlan.value = plan;
                      _selectedPlanId = value; // Store the selected plan ID
                    },
                    activeColor: AppColors.secondary,
                  ),
                ));
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel', style: TextStyle(color: AppColors.secondary)),
            ),
            TextButton(
              onPressed: () async {
                if (selectedPlanId.value != null && selectedPlanId.value!.isNotEmpty) {
                  final userId = await SharedPrefHelper.getUserData('id');

                  if (userId == null || userId.isEmpty) {
                    Get.snackbar('Error', 'User ID not found. Please log in again.',
                        backgroundColor: Colors.red, colorText: Colors.white);
                    return;
                  }

                  // Submit customer plan first
                  await customerPlanController.submitCustomerPlan(
                    propertyId: controller.propertyId.value ?? '',
                    userId: userId,
                    planDaysId: selectedPlanId.value ?? '',
                  );

                  Get.back();

                  // Store the selected plan ID
                  _selectedPlanId = selectedPlanId.value;

                  // Start Razorpay payment with order creation
                  await _startRazorpayWithOrder(
                    selectedPlan.value.totalPrice.toString(),
                    selectedPlanId.value ?? '',
                  );
                } else {
                  Get.snackbar('Error', 'Please select a plan',
                      backgroundColor: Colors.red, colorText: Colors.white);
                }
              },
              child: const Text('Proceed to Pay', style: TextStyle(color: AppColors.secondary)),
            ),
          ],
        );
      }),
    );
  }
}