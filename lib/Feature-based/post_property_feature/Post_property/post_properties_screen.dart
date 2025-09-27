// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
//
// class PincodeData {
//   final double latitude;
//   final double longitude;
//
//   PincodeData({required this.latitude, required this.longitude});
//
//   factory PincodeData.fromJson(Map<String, dynamic> json) {
//     return PincodeData(
//       latitude: double.parse(json[0]['lat']),
//       longitude: double.parse(json[0]['lon']),
//     );
//   }
// }
//
// class CreatePropertyController extends GetxController {
//   // Common text controllers
//   final titleController = TextEditingController();
//   final propertyForController = TextEditingController();
//   final propertyCategoryController = TextEditingController();
//   final propertyStatusController = TextEditingController();
//   final priceController = TextEditingController();
//   final bookingAmountController = TextEditingController();
//   final maintenanceChargesController = TextEditingController();
//   final reraNumberController = TextEditingController();
//   final streetNameController = TextEditingController();
//   final pinCodeController = TextEditingController();
//   final longitudeController = TextEditingController(text: '78.1245');
//   final latitudeController = TextEditingController(text: '78.1245');
//   final floorPlanTitleController = TextEditingController();
//   final floorPlanAreaController = TextEditingController();
//   final floorPlanDescriptionController = TextEditingController();
//
//   // Category-specific controllers
//   final totalAreaController = TextEditingController();
//   final builtupAreaController = TextEditingController();
//   final bedroomsController = TextEditingController();
//   final bathroomsController = TextEditingController();
//   final parkingController = TextEditingController();
//   final villaBuiltupAreaController = TextEditingController();
//   final villaFloorsController = TextEditingController();
//   final villaGardenController = TextEditingController();
//   final plotAreaController = TextEditingController();
//   final plotLengthController = TextEditingController();
//   final plotWidthController = TextEditingController();
//   final facingDirectionController = TextEditingController();
//   final commercialAreaController = TextEditingController();
//   final floorLevelController = TextEditingController();
//   final suitableForController = TextEditingController();
//
//   var isLoading = false.obs;
//   var selectedState = Rxn<StatesModelData>();
//   var selectedDistrict = Rxn<DistrictData>();
//   var selectedMandal = Rxn<MandalData>();
//   var selectedVillage = Rxn<VillageData>();
//   var selectedCategory = Rxn<CategoryData>();
//   var currentStep = 0.obs;
//
//   final stateController = Get.find<StateController>();
//   final districtController = Get.find<DistrictController>();
//   final mandalController = Get.find<MandalController>();
//   final villageController = Get.find<VillageController>();
//
//   // Add this method to fetch coordinates from pincode
//   Future<void> fetchCoordinatesFromPincode(String pincode) async {
//     if (pincode.isEmpty || pincode.length != 6) return;
//
//     try {
//       final response = await http.get(
//         Uri.parse('https://nominatim.openstreetmap.org/search?postalcode=$pincode&country=India&format=json'),
//       );
//
//       if (response.statusCode == 200) {
//         final List<dynamic> data = json.decode(response.body);
//         if (data.isNotEmpty) {
//           final pincodeData = PincodeData.fromJson(data as Map<String, dynamic>);
//           latitudeController.text = pincodeData.latitude.toStringAsFixed(6);
//           longitudeController.text = pincodeData.longitude.toStringAsFixed(6);
//
//           // Print to console
//           print('Fetched coordinates for pincode $pincode:');
//           print('Latitude: ${pincodeData.latitude.toStringAsFixed(6)}');
//           print('Longitude: ${pincodeData.longitude.toStringAsFixed(6)}');
//         } else {
//           Get.snackbar('Error', 'No location found for this pincode',
//               backgroundColor: Colors.red, colorText: Colors.white);
//           print('No location found for pincode: $pincode');
//         }
//       }
//     } catch (e) {
//       print('Error fetching coordinates: $e');
//     }
//   }
//
//   void updateCategoryData(CategoryData? categoryData) {
//     selectedCategory.value = categoryData;
//     propertyCategoryController.text = categoryData?.id ?? '';
//     clearCategorySpecificFields();
//   }
//
//   void clearCategorySpecificFields() {
//     totalAreaController.clear();
//     builtupAreaController.clear();
//     bedroomsController.clear();
//     bathroomsController.clear();
//     parkingController.clear();
//     villaBuiltupAreaController.clear();
//     villaFloorsController.clear();
//     villaGardenController.clear();
//     plotAreaController.clear();
//     plotLengthController.clear();
//     plotWidthController.clear();
//     facingDirectionController.clear();
//     commercialAreaController.clear();
//     floorLevelController.clear();
//     suitableForController.clear();
//   }
//
//   Map<String, String> get formData {
//     final data = {
//       'user_id': '60',
//       'title': titleController.text,
//       'property_for': propertyForController.text,
//       'property_cat_id': propertyCategoryController.text,
//       'property_status_id': propertyStatusController.text,
//       'price': priceController.text,
//       'booking_amount': bookingAmountController.text,
//       'maintenance_charges': maintenanceChargesController.text,
//       'rera_number': reraNumberController.text,
//       'state_id': selectedState.value?.id?.toString() ?? '',
//       'district_id': selectedDistrict.value?.id?.toString() ?? '',
//       'mandal_id': selectedMandal.value?.id?.toString() ?? '',
//       'village_id': selectedVillage.value?.id?.toString() ?? '',
//       'street_name': streetNameController.text,
//       'pin_code': pinCodeController.text,
//       'longitude': longitudeController.text,
//       'latitude': latitudeController.text,
//       'floor_plan_title': floorPlanTitleController.text,
//       'floor_plan_area': floorPlanAreaController.text,
//       'floor_plan_description': floorPlanDescriptionController.text,
//       'active':'Active'
//     };
//
//     if (selectedCategory.value?.propertyCategoryTitle == 'Apartment') {
//       data.addAll({
//         'total_area': totalAreaController.text,
//         'builtup_area': builtupAreaController.text,
//         'bedrooms': bedroomsController.text,
//         'bathrooms': bathroomsController.text,
//         'parking': parkingController.text,
//       });
//     } else if (selectedCategory.value?.propertyCategoryTitle == 'Villa') {
//       data.addAll({
//         'villa_builtup_area': villaBuiltupAreaController.text,
//         'villa_floors': villaFloorsController.text,
//         'villa_garden': villaGardenController.text,
//       });
//     } else if (selectedCategory.value?.propertyCategoryTitle == 'Plot') {
//       data.addAll({
//         'plot_area': plotAreaController.text,
//         'plot_length': plotLengthController.text,
//         'plot_width': plotWidthController.text,
//         'facing_direction': facingDirectionController.text,
//       });
//     } else if (selectedCategory.value?.propertyCategoryTitle == 'Commercial Space') {
//       data.addAll({
//         'commercial_area': commercialAreaController.text,
//         'floor_level': floorLevelController.text,
//         'suitable_for': suitableForController.text,
//       });
//     }
//
//     return data;
//   }
//
//   Future<void> submitProperty(GlobalKey<FormState> formKey) async {
//     if (!formKey.currentState!.validate()) {
//       Get.snackbar('Error', 'Please fill all required fields', backgroundColor: Colors.red, colorText: Colors.white);
//       return;
//     }
//
//     // Additional validation for required IDs
//     if (propertyCategoryController.text.isEmpty) {
//       Get.snackbar('Error', 'Property category is required', backgroundColor: Colors.red, colorText: Colors.white);
//       return;
//     }
//     if (propertyStatusController.text.isEmpty) {
//       Get.snackbar('Error', 'Property status is required', backgroundColor: Colors.red, colorText: Colors.white);
//       return;
//     }
//     if (selectedState.value?.id == null) {
//       Get.snackbar('Error', 'State is required', backgroundColor: Colors.red, colorText: Colors.white);
//       return;
//     }
//     if (selectedDistrict.value?.id == null) {
//       Get.snackbar('Error', 'District is required', backgroundColor: Colors.red, colorText: Colors.white);
//       return;
//     }
//     if (selectedMandal.value?.id == null) {
//       Get.snackbar('Error', 'Mandal is required', backgroundColor: Colors.red, colorText: Colors.white);
//       return;
//     }
//     if (selectedVillage.value?.id == null) {
//       Get.snackbar('Error', 'Village is required', backgroundColor: Colors.red, colorText: Colors.white);
//       return;
//     }
//
//     isLoading.value = true;
//     var headers = {'Cookie': 'ci_session=f1b618f9f875d808eb351470566184311786b179'};
//
//     var request = http.MultipartRequest(
//       'POST',
//       Uri.parse('https://madanvasu.in/new/apis/Api_properties/create_property'),
//     );
//
//     // Print formData for debugging
//     print('Form Data: ${formData.toString()}');
//     request.fields.addAll(formData);
//     request.headers.addAll(headers);
//
//     try {
//       http.StreamedResponse response = await request.send();
//       String responseBody = await response.stream.bytesToString();
//       // Print response for debugging
//       print('API Response: Status Code: ${response.statusCode}, Body: $responseBody');
//       if (response.statusCode == 200 ) {
//         Get.snackbar('Success', 'Property created successfully!', backgroundColor: Colors.green, colorText: Colors.white);
//         // Clear form after successful submission
//         titleController.clear();
//         propertyForController.clear();
//         propertyCategoryController.clear();
//         propertyStatusController.clear();
//         priceController.clear();
//         bookingAmountController.clear();
//         maintenanceChargesController.clear();
//         reraNumberController.clear();
//         streetNameController.clear();
//         pinCodeController.clear();
//         longitudeController.clear();
//         latitudeController.clear();
//         floorPlanTitleController.clear();
//         floorPlanAreaController.clear();
//         floorPlanDescriptionController.clear();
//         clearCategorySpecificFields();
//         selectedState.value = null;
//         selectedDistrict.value = null;
//         selectedMandal.value = null;
//         selectedVillage.value = null;
//         selectedCategory.value = null;
//         currentStep.value = 0;
//       } else {
//         Get.snackbar('Error', 'Failed: $responseBody', backgroundColor: Colors.red, colorText: Colors.white);
//       }
//     } catch (e) {
//       print('Exception: $e');
//       Get.snackbar('Error', 'Exception: $e', backgroundColor: Colors.red, colorText: Colors.white);
//     } finally {
//       isLoading.value = false;
//     }
//   }
//
//   @override
//   void onClose() {
//     titleController.dispose();
//     propertyForController.dispose();
//     propertyCategoryController.dispose();
//     propertyStatusController.dispose();
//     priceController.dispose();
//     bookingAmountController.dispose();
//     maintenanceChargesController.dispose();
//     reraNumberController.dispose();
//     streetNameController.dispose();
//     pinCodeController.dispose();
//     longitudeController.dispose();
//     latitudeController.dispose();
//     floorPlanTitleController.dispose();
//     floorPlanAreaController.dispose();
//     floorPlanDescriptionController.dispose();
//     totalAreaController.dispose();
//     builtupAreaController.dispose();
//     bedroomsController.dispose();
//     bathroomsController.dispose();
//     parkingController.dispose();
//     villaBuiltupAreaController.dispose();
//     villaFloorsController.dispose();
//     villaGardenController.dispose();
//     plotAreaController.dispose();
//     plotLengthController.dispose();
//     plotWidthController.dispose();
//     facingDirectionController.dispose();
//     commercialAreaController.dispose();
//     floorLevelController.dispose();
//     suitableForController.dispose();
//     super.onClose();
//   }
// }
//
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
//         elevation: 2,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//         child: TextFormField(
//           controller: controller,
//           readOnly: readOnly,
//           maxLines: maxLines,
//           decoration: InputDecoration(
//             labelText: label,
//             filled: true,
//             fillColor: Colors.white,
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12),
//               borderSide: BorderSide.none,
//             ),
//             prefixIcon: Icon(Icons.edit, color: AppColors.secondary),
//           ),
//           keyboardType: keyboardType,
//           validator: validator,
//           onChanged: onChanged != null ? (value) => onChanged() : null,
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
//     final formKey1 = GlobalKey<FormState>();
//     final formKey2 = GlobalKey<FormState>();
//     final formKey3 = GlobalKey<FormState>();
//
//     return Scaffold(
//       // backgroundColor: Colors.white,
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         backgroundColor: Colors.white.withOpacity(0.2),
//
//         title: const Text('Create Property',
//           style: TextStyle(
//             color: Colors.black,
//             fontSize: 22,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         centerTitle: true,
//         elevation: 0,
//         // backgroundColor: AppColors.secondary,
//         titleTextStyle: const TextStyle(
//           color: Colors.white,
//           fontSize: 20,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//       body: Column(
//         children: [
//           // Stepper-like progress indicator
//           Container(
//             color: Colors.white,
//             padding: const EdgeInsets.symmetric(vertical: 10),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 GestureDetector(
//                   onTap: () => controller.currentStep.value = 0,
//                   child: _buildStep('Property Details', controller.currentStep.value == 0, Icons.description),
//                 ),
//                 GestureDetector(
//                   onTap: () => controller.currentStep.value = 1,
//                   child: _buildStep('Location Details', controller.currentStep.value == 1, Icons.location_on),
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
//                 return const Center(child: CircularProgressIndicator());
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
//                       controller.currentStep.value = 1;
//                     }
//                   };
//                   content = Form(
//                     key: formKey1,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Padding(
//                           padding: EdgeInsets.all(16.0),
//                           child: Text(
//                             'Property Details',
//                             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
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
//                             elevation: 2,
//                             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                             child: DropdownButtonFormField<String>(
//                               decoration: InputDecoration(
//                                 labelText: 'Property For',
//                                 filled: true,
//                                 fillColor: Colors.white,
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(12),
//                                   borderSide: BorderSide.none,
//                                 ),
//                                 prefixIcon: Icon(Icons.category, color: AppColors.secondary),
//                               ),
//                               value: controller.propertyForController.text.isEmpty ||
//                                   !['Sell', 'Rent'].contains(controller.propertyForController.text)
//                                   ? null
//                                   : controller.propertyForController.text,
//                               items: ['Sell', 'Rent'].map((propertyFor) {
//                                 return DropdownMenuItem<String>(
//                                   value: propertyFor,
//                                   child: Text(propertyFor),
//                                 );
//                               }).toList(),
//                               onChanged: (newValue) {
//                                 if (newValue != null) {
//                                   controller.propertyForController.text = newValue;
//                                 }
//                               },
//                               validator: (val) => val == null || val.isEmpty ? 'Please select property for' : null,
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(vertical: 8.0),
//                           child: Card(
//                             elevation: 2,
//                             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                             child: DropdownButtonFormField<String>(
//                               isExpanded: true,
//                               decoration: InputDecoration(
//                                 labelText: 'Property Category',
//                                 filled: true,
//                                 fillColor: Colors.white,
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(12),
//                                   borderSide: BorderSide.none,
//                                 ),
//                                 prefixIcon: Icon(Icons.category, color: AppColors.secondary),
//                               ),
//                               value: controller.propertyCategoryController.text.isEmpty
//                                   ? null
//                                   : controller.propertyCategoryController.text,
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
//                                 }
//                               },
//                               validator: (val) => val == null || val.isEmpty ? 'Please select a category' : null,
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(vertical: 8.0),
//                           child: Card(
//                             elevation: 2,
//                             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                             child: DropdownButtonFormField<String>(
//                               isExpanded: true,
//                               decoration: InputDecoration(
//                                 labelText: 'Property Status',
//                                 filled: true,
//                                 fillColor: Colors.white,
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(12),
//                                   borderSide: BorderSide.none,
//                                 ),
//                                 prefixIcon: Icon(Icons.info, color: AppColors.secondary),
//                               ),
//                               value: controller.propertyStatusController.text.isEmpty
//                                   ? null
//                                   : controller.propertyStatusController.text,
//                               items: propertyStatusController.propertyStatusList.map((status) {
//                                 return DropdownMenuItem<String>(
//                                   value: status.id,
//                                   child: Text(status.propertyStatus),
//                                 );
//                               }).toList(),
//                               onChanged: (newValue) {
//                                 if (newValue != null) {
//                                   controller.propertyStatusController.text = newValue;
//                                 }
//                               },
//                               validator: (val) => val == null || val.isEmpty ? 'Please select a status' : null,
//                             ),
//                           ),
//                         ),
//                         _buildTextField(
//                           controller: controller.priceController,
//                           label: 'Listing Price',
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
//                               children: [
//                                 const Padding(
//                                   padding: EdgeInsets.symmetric(vertical: 16.0),
//                                   child: Text(
//                                     'Apartment Details',
//                                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
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
//                               children: [
//                                 const Padding(
//                                   padding: EdgeInsets.symmetric(vertical: 16.0),
//                                   child: Text(
//                                     'Villa Details',
//                                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
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
//                               children: [
//                                 const Padding(
//                                   padding: EdgeInsets.symmetric(vertical: 16.0),
//                                   child: Text(
//                                     'Plot Details',
//                                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
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
//                               children: [
//                                 const Padding(
//                                   padding: EdgeInsets.symmetric(vertical: 16.0),
//                                   child: Text(
//                                     'Commercial Space Details',
//                                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
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
//                       controller.currentStep.value = 2;
//                     }
//                   };
//                   content = Form(
//                     key: formKey2,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Padding(
//                           padding: EdgeInsets.all(16.0),
//                           child: Text(
//                             'Location Details',
//                             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
//                           ),
//                         ),
//                         Obx(() {
//                           final states = controller.stateController.statesList;
//                           if (controller.stateController.isLoading.value) {
//                             return const Center(child: CircularProgressIndicator());
//                           }
//                           if (states.isEmpty) {
//                             return const Padding(
//                               padding: EdgeInsets.symmetric(vertical: 8.0),
//                               child: Text('No states available', style: TextStyle(color: Colors.red)),
//                             );
//                           }
//                           return Padding(
//                             padding: const EdgeInsets.symmetric(vertical: 8.0),
//                             child: Card(
//                               elevation: 2,
//                               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                               child: DropdownButtonFormField<StatesModelData>(
//                                 isExpanded: true,
//                                 decoration: InputDecoration(
//                                   labelText: 'Select State',
//                                   filled: true,
//                                   fillColor: Colors.white,
//                                   border: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(12),
//                                     borderSide: BorderSide.none,
//                                   ),
//                                   prefixIcon: Icon(Icons.flag, color: AppColors.secondary),
//                                 ),
//                                 value: controller.selectedState.value,
//                                 items: states.map((state) {
//                                   return DropdownMenuItem<StatesModelData>(
//                                     value: state,
//                                     child: Text(state.stateName ?? ''),
//                                   );
//                                 }).toList(),
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
//                         Obx(() {
//                           final selectedState = controller.selectedState.value;
//                           final districts = controller.districtController.districtList;
//                           final isDistrictLoading = controller.districtController.isLoading.value;
//                           if (selectedState == null) return const SizedBox();
//                           if (isDistrictLoading) return const Center(child: CircularProgressIndicator());
//                           if (districts.isEmpty) {
//                             return const Padding(
//                               padding: EdgeInsets.symmetric(vertical: 8.0),
//                               child: Text('No districts available', style: TextStyle(color: Colors.red)),
//                             );
//                           }
//                           return Padding(
//                             padding: const EdgeInsets.symmetric(vertical: 8.0),
//                             child: Card(
//                               elevation: 2,
//                               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                               child: DropdownButtonFormField<DistrictData>(
//                                 isExpanded: true,
//                                 decoration: InputDecoration(
//                                   labelText: 'Select District',
//                                   filled: true,
//                                   fillColor: Colors.white,
//                                   border: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(12),
//                                     borderSide: BorderSide.none,
//                                   ),
//                                   prefixIcon: Icon(Icons.location_city, color: AppColors.secondary),
//                                 ),
//                                 value: controller.selectedDistrict.value,
//                                 items: districts.map((district) {
//                                   return DropdownMenuItem<DistrictData>(
//                                     value: district,
//                                     child: Text(district.districtName),
//                                   );
//                                 }).toList(),
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
//                         Obx(() {
//                           final selectedDistrict = controller.selectedDistrict.value;
//                           final mandals = controller.mandalController.mandalList;
//                           final isMandalLoading = controller.mandalController.isLoading.value;
//                           if (selectedDistrict == null || (!isMandalLoading && mandals.isEmpty)) return const SizedBox();
//                           if (isMandalLoading) return const Center(child: CircularProgressIndicator());
//                           return Padding(
//                             padding: const EdgeInsets.symmetric(vertical: 8.0),
//                             child: Card(
//                               elevation: 2,
//                               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                               child: DropdownButtonFormField<MandalData>(
//                                 isExpanded: true,
//                                 decoration: InputDecoration(
//                                   labelText: 'Select Mandal',
//                                   filled: true,
//                                   fillColor: Colors.white,
//                                   border: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(12),
//                                     borderSide: BorderSide.none,
//                                   ),
//                                   prefixIcon: Icon(Icons.map_outlined, color: AppColors.secondary),
//                                 ),
//                                 value: controller.selectedMandal.value,
//                                 items: mandals.map((mandal) {
//                                   return DropdownMenuItem<MandalData>(
//                                     value: mandal,
//                                     child: Text(mandal.mandalName),
//                                   );
//                                 }).toList(),
//                                 onChanged: (value) async {
//                                   controller.selectedMandal.value = value;
//                                   controller.selectedVillage.value = null;
//                                   controller.villageController.clearVillages();
//                                   if (value != null && controller.selectedState.value != null && controller.selectedDistrict.value != null) {
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
//                         Obx(() {
//                           final selectedMandal = controller.selectedMandal.value;
//                           final villages = controller.villageController.villageList;
//                           final isVillageLoading = controller.villageController.isLoading.value;
//                           if (selectedMandal == null || (!isVillageLoading && villages.isEmpty)) return const SizedBox();
//                           if (isVillageLoading) return const Center(child: CircularProgressIndicator());
//                           return Padding(
//                             padding: const EdgeInsets.symmetric(vertical: 8.0),
//                             child: Card(
//                               elevation: 2,
//                               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                               child: DropdownButtonFormField<VillageData>(
//                                 isExpanded: true,
//                                 decoration: InputDecoration(
//                                   labelText: 'Select Village',
//                                   filled: true,
//                                   fillColor: Colors.white,
//                                   border: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(12),
//                                     borderSide: BorderSide.none,
//                                   ),
//                                   prefixIcon: Icon(Icons.home_outlined, color: AppColors.secondary),
//                                 ),
//                                 value: controller.selectedVillage.value,
//                                 items: villages.map((village) {
//                                   return DropdownMenuItem<VillageData>(
//                                     value: village,
//                                     child: Text(village.villageName),
//                                   );
//                                 }).toList(),
//                                 onChanged: (value) {
//                                   controller.selectedVillage.value = value;
//                                 },
//                                 validator: (value) => value == null ? 'Please select a village' : null,
//                               ),
//                             ),
//                           );
//                         }),
//                         _buildTextField(
//                           controller: controller.streetNameController,
//                           label: 'Street Name',
//                         ),
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
//                         _buildTextField(
//                           controller: controller.longitudeController,
//                           label: 'Longitude',
//                           keyboardType: TextInputType.number,
//                           readOnly: true,
//                         ),
//                         _buildTextField(
//                           controller: controller.latitudeController,
//                           label: 'Latitude',
//                           keyboardType: TextInputType.number,
//                           readOnly: true,
//                         ),
//                       ],
//                     ),
//                   );
//                   break;
//                 case 2:
//                   currentFormKey = formKey3;
//                   buttonText = 'Submit';
//                   onButtonPressed = () => controller.submitProperty(formKey3);
//                   content = Form(
//                     key: formKey3,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Padding(
//                           padding: EdgeInsets.all(16.0),
//                           child: Text(
//                             'Floor Plan Details',
//                             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
//                           ),
//                         ),
//                         _buildTextField(
//                           controller: controller.floorPlanTitleController,
//                           label: 'Floor Plan Title',
//                         ),
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
//               return SingleChildScrollView(
//                 padding: const EdgeInsets.all(16),
//                 child: Column(
//                   children: [
//                     content,
//                     const SizedBox(height: 16),
//                     Center(
//                       child: SizedBox(
//                         width: 200,
//                         child: ElevatedButton(
//                           onPressed: onButtonPressed,
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: AppColors.secondary,
//                             padding: const EdgeInsets.symmetric(vertical: 12),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                           ),
//                           child: Text(
//                             buttonText,
//                             style: const TextStyle(color: Colors.white, fontSize: 16),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             }),
//           ),
//         ],
//       ),
//       bottomNavigationBar: CustomBottomNavigationBar(
//         currentIndex: 2,
//         toggleTheme: () {},
//         primaryColor: AppColors.secondary,
//         bottomNavbarColor: AppColors.primary,
//         cardColor: AppColors.backgroundColorProfile,
//       ),
//     );
//   }
//
//   Widget _buildStep(String title, bool isActive, IconData icon) {
//     return Column(
//       children: [
//         Container(
//           width: 40,
//           height: 40,
//           decoration: BoxDecoration(
//             color: isActive ? AppColors.secondary : Colors.grey[300],
//             shape: BoxShape.circle,
//           ),
//           child: Icon(icon, color: isActive ? Colors.white : Colors.grey),
//         ),
//         const SizedBox(height: 8),
//         Text(
//           title,
//           style: TextStyle(
//             color: isActive ? AppColors.secondary : Colors.grey[600],
//             fontSize: 12,
//           ),
//         ),
//       ],
//     );
//   }
// }