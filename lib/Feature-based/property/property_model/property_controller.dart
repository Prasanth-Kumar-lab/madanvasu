//
// import 'dart:convert';
//
// import 'package:flutter/cupertino.dart';
// import 'package:madhanvasu_app/Feature-based/property/property_model/property_model.dart';
// import '../../../main.dart';
// import 'package:http/http.dart'as http;
//
// class PropertyController extends ChangeNotifier {
//   GetAllProperties? propertiesData;
//   bool isLoading = false;
//   String? errorMessage;
//   String? selectedCategoryId;
//
//
//   Future<void> fetchProperties(String categoryId) async {
//     selectedCategoryId = categoryId; // Store for filtering
//     isLoading = true;
//     errorMessage = null;
//     notifyListeners();
//
//     try {
//       var headers = {
//         'Cookie': 'ci_session=766864de3cd2b5b681a44712c1d84a86d5e491b2'
//       };
//       var request = http.Request(
//         'GET',
//         Uri.parse('https://madanvasu.in/new/apis/Api_properties/get_properties'),
//       );
//       request.headers.addAll(headers);
//
//       http.StreamedResponse response = await request.send();
//
//       if (response.statusCode == 200) {
//         final responseBody = await response.stream.bytesToString();
//         final jsonData = jsonDecode(responseBody);
//         propertiesData = GetAllProperties.fromJson(jsonData);
//       } else {
//         errorMessage = response.reasonPhrase;
//       }
//     } catch (e) {
//       errorMessage = e.toString();
//     } finally {
//       isLoading = false;
//       notifyListeners();
//     }
//   }
//
// }