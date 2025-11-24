import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../Feature-based/MY_properties_list/my_properties_list_model.dart';
import '../../Feature-based/Reviews/All_Reviews_list/List_Reviews_model.dart';
import '../../Feature-based/SavedProperties/saved_properties_model.dart';
import '../../Feature-based/auth/loging_model/login_model.dart';
import '../../Feature-based/categorys/categorys_model/categorys_model.dart';
// import '../../Feature-based/home/categorys/categorys_model/categorys_model.dart';
import '../../Feature-based/home/FeaturedPoperties/FeaturedProperties_model.dart';
import '../../Feature-based/post_property_feature/property_plan_days/property_plan_days_model.dart';
import '../../Feature-based/post_property_feature/property_price_per_day/price_per_days_modle.dart';
import '../../Feature-based/property_details/Property_details_model.dart';
import '../../Feature-based/property_status/propertys_status_model.dart';
import '../../Feature-based/states&districts/districts/districts_model.dart';
import '../../Feature-based/states&districts/mandals/mandals_model.dart';
import '../../Feature-based/states&districts/states/States_model.dart';
import '../../Feature-based/states&districts/villages/villages_model.dart';
import '../../app/configuration/themes/api_end_points.dart';

class ApiService {

  static Future<LoginModel?> login(
      String username,
      String password,
      String fcmToken,
      ) async {
    try {
      print('FCM Token: $fcmToken');

      var url = Uri.parse('${ApiEndpoints.baseUrl}${ApiEndpoints.loginUrl}');
      print('Login API URL: $url');
      var request = http.MultipartRequest('POST', url);

      request.fields.addAll({
        'username': username,
        'password': password,
        'active_status': 'Active',
        'fcm_token': fcmToken,
      });

      request.headers.addAll({
        'Cookie': 'ci_session=e505572173f95a9ade95649e3cc7361d0a43bf68',
      });

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        final responseString = await response.stream.bytesToString();
        print('Response Bodyyyyyyy: $responseString');

        final jsonResponse = jsonDecode(responseString);

        if (jsonResponse['status'] == true && jsonResponse['data'] != null) {
          return LoginModel.fromJson(jsonResponse);
        } else {
          print("Login failed: ${jsonResponse['message'] ?? 'Unknown error'}");
          return null;
        }
      } else {
        print('HTTP Error: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Login API Exception: $e');
      return null;
    }
  }


  ////////////////// REGISTER API 2

   static Future<Map<String, dynamic>> registerUser({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String districtId,
    required String mandalId,
    required String villageId,
    required String stateId,
  }) async {
    try {
      var url = Uri.parse(
          '${ApiEndpoints.baseUrl}${ApiEndpoints.registerUser}');
      print('registerUser API URL: $url');

      var request = http.MultipartRequest('POST', url);

      request.fields.addAll({
        'person_name': name,
        'email': email,
        'mobile_number': phone,
        'password': password,
        'terms_conditions': 'Agreed',
        'location_id': '1',
        'state_id': stateId,
        'district_id': districtId,
        'mandal_id': mandalId,
        'village_id': villageId,
      });

      print('Sending fields: ${request.fields}');

      final response = await request.send();
      final responseString = await response.stream.bytesToString();
      print('Response Body: $responseString');

      final json = jsonDecode(responseString);

      return {
        'status': json['status'] ?? false,
        'message': json['message'] ?? 'Unknown error',
      };
    } catch (e) {
      print(' Registration exception: $e');
      return {
        'status': false,
        'message': 'Exception occurred during registration',
      };
    }
  }


//////////////////////////////////////  fetchCategories API 3

  Future<List<CategoryData>> fetchCategories() async {
    try {
      var headers = {
        'Cookie': 'ci_session=2452eed443c5c43e0661b6757d0e066bc63b484a'
      };

      var url = Uri.parse(
          '${ApiEndpoints.baseUrl}${ApiEndpoints.getcategories}');
      var request = http.Request('GET', url);

      print("getcategories_Api URL : $url");

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        String jsonString = await response.stream.bytesToString();

        print("Raw JSON response: $jsonString");

        final jsonMap = json.decode(jsonString);

        print("Parsed JSON map: $jsonMap");

        final categoryModel = CategoriesModel.fromJson(jsonMap);

        print("Parsed Categories: ${categoryModel.data}");

        return categoryModel.data;
      } else {
        throw Exception("Failed to fetch categories: ${response.reasonPhrase}");
      }
    } catch (e) {
      throw Exception("Error fetching categories: $e");
    }
  }

////////////PropertiesWrapper API 4


  Future<PropertiesDataWrapper?> PropertiesWrapper() async {
    final Map<String, String> _headers = {
      'Cookie': 'ci_session=3fb359700b5bfe52ced1fc876f9390b37aee9b0b',
    };

    try {
      final uri = Uri.parse(
          '${ApiEndpoints.baseUrl}${ApiEndpoints.propertieslist_Bystatus}');
      final request = http.Request('GET', uri)
        ..headers.addAll(_headers);

      print("Properties API URLlllllll: $uri");

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();

        print("Response Body: $responseBody");

        final decoded = json.decode(responseBody);

        final model = PropertiesListModel.fromJson(decoded);
        return model.data;
      } else {
        throw Exception("Failed to load properties: ${response.reasonPhrase}");
      }
    } catch (e) {
      throw Exception("Error fetching properties: $e");
    }
  }

///////////////////////Available_PropertiesWrapper API 5


  Future<PropertiesDataWrapper?> Available_PropertiesWrapper() async {
    final Map<String, String> _headers = {
      'Cookie': 'ci_session=3fb359700b5bfe52ced1fc876f9390b37aee9b0b',
    };

    try {
      final uri = Uri.parse(
          '${ApiEndpoints.baseUrl}${ApiEndpoints.Available_propertieslist}');
      final request = http.Request('GET', uri)
        ..headers.addAll(_headers);

      print("Properties API URLlllllll: $uri");

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();

        print("Response Body: $responseBody");

        final decoded = json.decode(responseBody);

        final model = PropertiesListModel.fromJson(decoded);
        return model.data;
      } else {
        throw Exception("Failed to load properties: ${response.reasonPhrase}");
      }
    } catch (e) {
      throw Exception("Error fetching properties: $e");
    }
  }

///////////////////////////////////Rented_PropertiesWrapper  API 6


  Future<PropertiesDataWrapper?> Rented_PropertiesWrapper() async {
    final Map<String, String> _headers = {
      'Cookie': 'ci_session=3fb359700b5bfe52ced1fc876f9390b37aee9b0b',
    };

    try {
      final uri = Uri.parse(
          '${ApiEndpoints.baseUrl}${ApiEndpoints.Rented_propertieslist}');
      final request = http.Request('GET', uri)
        ..headers.addAll(_headers);

      print("Properties API URLlllllll: $uri");

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();

        print("Response Body: $responseBody");

        final decoded = json.decode(responseBody);

        final model = PropertiesListModel.fromJson(decoded);
        return model.data;
      } else {
        throw Exception("Failed to load properties: ${response.reasonPhrase}");
      }
    } catch (e) {
      throw Exception("Error fetching properties: $e");
    }
  }

  ////////////////////////  Sold_PropertiesWrapper API 7

  Future<PropertiesDataWrapper?> Sold_PropertiesWrapper() async {
    final Map<String, String> _headers = {
      'Cookie': 'ci_session=3fb359700b5bfe52ced1fc876f9390b37aee9b0b',
    };

    try {
      final uri = Uri.parse(
          '${ApiEndpoints.baseUrl}${ApiEndpoints.sold_propertieslist}');
      final request = http.Request('GET', uri)
        ..headers.addAll(_headers);

      print("Properties API URLlllllll: $uri");

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();

        print("Response Body: $responseBody");

        final decoded = json.decode(responseBody);

        final model = PropertiesListModel.fromJson(decoded);
        return model.data;
      } else {
        throw Exception("Failed to load properties: ${response.reasonPhrase}");
      }
    } catch (e) {
      throw Exception("Error fetching properties: $e");
    }
  }

  //////////////////////////////////// categorys_based_on_Properties API 8


  Future<PropertiesDataWrapper?> categorys_based_on_Properties() async {
    final Map<String, String> _headers = {
      'Cookie': 'ci_session=3fb359700b5bfe52ced1fc876f9390b37aee9b0b',
    };

    try {
      final uri = Uri.parse('${ApiEndpoints.baseUrl}${ApiEndpoints
          .categorys_based_on_Properties}');
      final request = http.Request('GET', uri)
        ..headers.addAll(_headers);

      print("Properties API URLlllllll: $uri");

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();

        print("Response Body: $responseBody");

        final decoded = json.decode(responseBody);

        final model = PropertiesListModel.fromJson(decoded);
        return model.data;
      } else {
        throw Exception("Failed to load properties: ${response.reasonPhrase}");
      }
    } catch (e) {
      throw Exception("Error fetching properties: $e");
    }
  }


  ////////////////////////////// fetchPropertyDetails API 9


  // Future<PropertyDetailsModel?> fetchPropertyDetails(String propertyId) async {
  //   final String baseUrl = 'https://madanvasu.in/new/apis/Api_properties';
  //
  //   final url = Uri.parse('$baseUrl/get_property_details?property_id=$propertyId');
  //
  //   final Map<String, String> headers = {
  //     'Cookie': 'ci_session=5f0d9cfa80f508b281dd8f34a9666fe437af600d',
  //   };
  //
  //   try {
  //     var request = http.Request('GET', url);
  //     request.headers.addAll(headers);
  //
  //     final response = await request.send();
  //
  //     if (response.statusCode == 200) {
  //       final responseBody = await response.stream.bytesToString();
  //       final decodedJson = json.decode(responseBody);
  //       return PropertyDetailsModel.fromJson(decodedJson);
  //     } else {
  //       print('❌ Error: ${response.reasonPhrase}');
  //       return null;
  //     }
  //   } catch (e) {
  //     print('❗ Exception caught in repository: $e');
  //     return null;
  //   }
  // }


  Future<PropertyDetailsModel?> fetchPropertyDetails(String propertyId) async {
    final url = Uri.parse(
      '${ApiEndpoints.baseUrl}${ApiEndpoints
          .get_property_details}?property_id=$propertyId',
    );

    final Map<String, String> headers = {
      'Cookie': 'ci_session=5f0d9cfa80f508b281dd8f34a9666fe437af600d',
    };

    try {
      var request = http.Request('GET', url);
      request.headers.addAll(headers);

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        final decodedJson = json.decode(responseBody);
        return PropertyDetailsModel.fromJson(decodedJson);
      } else {
        print(' Error: ${response.reasonPhrase}');
        return null;
      }
    } catch (e) {
      print(' Exception caught in repository: $e');
      return null;
    }
  }


  ////////////////////////////////// add favvorite  API 10

  // static Future<Map<String, dynamic>> addFavoriteProperty({
  //   required String userId,
  //   required String propertyId,
  // }) async {
  //   var headers = {
  //     'Cookie': 'ci_session=edcc00a59e3f10a94343131ad0ffd952789c92c1',
  //   };
  //
  //   var request = http.MultipartRequest(
  //     'POST',
  //     Uri.parse(
  //         'https://madanvasu.in/new/apis/Api_favorite_properties/add_favorite_property'),
  //   );
  //
  //   request.fields.addAll({
  //     'user_id': userId,
  //     'property_id': propertyId,
  //   });
  //
  //   request.headers.addAll(headers);
  //
  //   try {
  //     http.StreamedResponse response = await request.send();
  //
  //     String responseData = await response.stream.bytesToString();
  //
  //     if (response.statusCode == 201 || response.statusCode == 200) {
  //       print("Success: $responseData");
  //       return jsonDecode(responseData);
  //     } else {
  //       print("Error: ${response.reasonPhrase}");
  //       return {
  //         'status': false,
  //         'message': 'Failed with status code: ${response.statusCode}'
  //       };
  //     }
  //   } catch (e) {
  //     print("Exception: $e");
  //     return {
  //       'status': false,
  //       'message': 'Exception occurred: $e',
  //     };
  //   }
  // }


  static Future<Map<String, dynamic>> addFavoriteProperty({
    required String userId,
    required String propertyId,
  }) async {
    final headers = {
      'Cookie': 'ci_session=edcc00a59e3f10a94343131ad0ffd952789c92c1',
    };

    final url = Uri.parse(
        '${ApiEndpoints.baseUrl}${ApiEndpoints.add_favorite_property}');

    final request = http.MultipartRequest('POST', url);

    request.fields.addAll({
      'user_id': userId,
      'property_id': propertyId,
    });

    request.headers.addAll(headers);

    try {
      final response = await request.send();
      final responseData = await response.stream.bytesToString();

      if (response.statusCode == 200 || response.statusCode == 201) {
        print(" Success: $responseData");
        return jsonDecode(responseData);
      } else {
        print(" Error: ${response.reasonPhrase}");
        return {
          'status': false,
          'message': 'Failed with status code: ${response.statusCode}',
        };
      }
    } catch (e) {
      print("Exception: $e");
      return {
        'status': false,
        'message': 'Exception occurred: $e',
      };
    }
  }


//////////////////////////////////////////////////removeFavoriteProperty API 11


  // static Future<void> removeFavoriteProperty({
  //   required String userId,
  //   required String propertyId,
  // }) async {
  //   var headers = {
  //     'Cookie': 'ci_session=edcc00a59e3f10a94343131ad0ffd952789c92c1',
  //   };
  //
  //   var request = http.MultipartRequest(
  //     'POST',
  //     Uri.parse('https://madanvasu.in/new/apis/Api_favorite_properties/remove_favourite_property'),
  //   );
  //
  //   request.fields.addAll({
  //     'user_id': userId,
  //     'property_id': propertyId,
  //   });
  //
  //   request.headers.addAll(headers);
  //
  //   try {
  //     http.StreamedResponse response = await request.send();
  //
  //     if (response.statusCode == 201 || response.statusCode == 200) {
  //       String responseData = await response.stream.bytesToString();
  //       print("Success: $responseData");
  //     } else {
  //       print("Error: ${response.reasonPhrase}");
  //     }
  //   } catch (e) {
  //     print("Exception: $e");
  //   }
  // }

  static Future<void> removeFavoriteProperty({
    required String userId,
    required String propertyId,
  }) async {
    final headers = {
      'Cookie': 'ci_session=edcc00a59e3f10a94343131ad0ffd952789c92c1',
    };

    final url = Uri.parse(
      '${ApiEndpoints.baseUrl}${ApiEndpoints.remove_favorite_property}',
    );

    print(" removeFavoriteProperty API URL: $url");

    final request = http.MultipartRequest('POST', url);

    request.fields.addAll({
      'user_id': userId,
      'property_id': propertyId,
    });

    request.headers.addAll(headers);

    try {
      final response = await request.send();

      final responseData = await response.stream.bytesToString();

      if (response.statusCode == 200 || response.statusCode == 201) {
        print(" Success: $responseData");
      } else {
        print(" Error ${response.statusCode}: ${response.reasonPhrase}");
      }
    } catch (e) {
      print(" Exception occurred: $e");
    }
  }


  ///////////////////////////////////////// fetch  fav vorite items API 12

  // Future<FavoritePropertiesResponse> fetchFavoriteProperties(String userId) async {
  //   var headers = {
  //     'Cookie': 'ci_session=3802ff23a50e93a76844d3fee7cdeb3c34d0c66c',
  //   };
  //
  //   var url = Uri.parse(
  //       'https://madanvasu.in/new/apis/Api_favorite_properties/user_favorite_properties_list?user_id=$userId');
  //
  //   var request = http.Request('GET', url);
  //   request.headers.addAll(headers);
  //
  //   http.StreamedResponse response = await request.send();
  //
  //   if (response.statusCode == 200) {
  //     String jsonString = await response.stream.bytesToString();
  //     Map<String, dynamic> jsonMap = json.decode(jsonString);
  //     return FavoritePropertiesResponse.fromJson(jsonMap);
  //   } else {
  //     throw Exception('Failed to load data: ${response.reasonPhrase}');
  //   }
  // }


  Future<FavoritePropertiesResponse> fetchFavoriteProperties(
      String userId) async {
    final headers = {
      'Cookie': 'ci_session=3802ff23a50e93a76844d3fee7cdeb3c34d0c66c',
    };

    final url = Uri.parse(
      '${ApiEndpoints.baseUrl}${ApiEndpoints
          .favorite_properties_list}?user_id=$userId',
    );

    print(" fetchFavoriteProperties API URL: $url");

    final request = http.Request('GET', url);
    request.headers.addAll(headers);

    final response = await request.send();

    if (response.statusCode == 200) {
      final jsonString = await response.stream.bytesToString();
      final Map<String, dynamic> jsonMap = json.decode(jsonString);
      return FavoritePropertiesResponse.fromJson(jsonMap);
    } else {
      throw Exception(' Failed to load data: ${response.statusCode} - ${response
          .reasonPhrase}');
    }
  }


  ////////////////----- submitReview API 13


  // static Future<String> submitReview({
  //   required String reviewText,
  //   required String propertyId,
  //   required String userId,
  // }) async {
  //   try {
  //     var headers = {
  //       'Cookie': 'ci_session=a0b0251eb18f24f7b7991eab66c87e7085ee2c66'
  //     };
  //
  //     var request = http.MultipartRequest(
  //       'POST',
  //       Uri.parse('https://madanvasu.in/new/apis/Api_property_reviews/add_property_review'),
  //     );
  //
  //     request.fields.addAll({
  //       'property_id': propertyId,
  //       'user_id': userId,
  //       'review_data': reviewText,
  //     });
  //
  //     request.headers.addAll(headers);
  //
  //     http.StreamedResponse response = await request.send();
  //
  //     if (response.statusCode == 201 || response.statusCode == 200) {
  //       return await response.stream.bytesToString();
  //     } else {
  //       throw Exception('Failed to submit review: ${response.reasonPhrase}');
  //     }
  //   } catch (e) {
  //     throw Exception('Error submitting review: $e');
  //   }
  // }


  static Future<String> submitReview({
    required String reviewText,
    required String propertyId,
    required String userId,
  }) async {
    final headers = {
      'Cookie': 'ci_session=a0b0251eb18f24f7b7991eab66c87e7085ee2c66',
    };

    final url = Uri.parse(
      '${ApiEndpoints.baseUrl}${ApiEndpoints.submit_property_review}',
    );

    print("submitReview API URL: $url");

    final request = http.MultipartRequest('POST', url);

    request.fields.addAll({
      'property_id': propertyId,
      'user_id': userId,
      'review_data': reviewText,
    });

    request.headers.addAll(headers);

    try {
      final response = await request.send();

      if (response.statusCode == 200 || response.statusCode == 201) {
        return await response.stream.bytesToString();
      } else {
        throw Exception(
            'Failed to submit review: ${response.statusCode} - ${response
                .reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Error submitting review: $e');
    }
  }


  //////////////////////// List_reviews  API 14


  // Future<PropertyReviewResponse> fetchPropertyReviews(String propertyId) async {
  //   var headers = {
  //     'Cookie': 'ci_session=a0b0251eb18f24f7b7991eab66c87e7085ee2c66',
  //   };
  //
  //   var url = Uri.parse(
  //     'https://madanvasu.in/new/apis/Api_property_reviews/user_property_reviews_list?property_id=$propertyId',
  //   );
  //
  //   print('Request URL: $url');
  //
  //   var request = http.Request('GET', url);
  //   request.headers.addAll(headers);
  //
  //   http.StreamedResponse response = await request.send();
  //
  //   print('Response Status Code: ${response.statusCode}');
  //
  //   if (response.statusCode == 200) {
  //     String jsonString = await response.stream.bytesToString();
  //
  //     print('Response Body: $jsonString');
  //
  //     Map<String, dynamic> jsonMap = json.decode(jsonString);
  //     return PropertyReviewResponse.fromJson(jsonMap);
  //   } else {
  //     print('Error Response: ${response.reasonPhrase}');
  //     throw Exception('Failed to load data: ${response.reasonPhrase}');
  //   }
  // }


  Future<PropertyReviewResponse> fetchPropertyReviews(String propertyId) async {
    final headers = {
      'Cookie': 'ci_session=a0b0251eb18f24f7b7991eab66c87e7085ee2c66',
    };

    final url = Uri.parse(
      '${ApiEndpoints.baseUrl}${ApiEndpoints
          .get_property_reviews}?property_id=$propertyId',
    );

    print(' fetchPropertyReviews API URL: $url');

    final request = http.Request('GET', url);
    request.headers.addAll(headers);

    final response = await request.send();

    print('Response Status Code: ${response.statusCode}');

    if (response.statusCode == 200) {
      final jsonString = await response.stream.bytesToString();

      print(' Response Body: $jsonString');

      final Map<String, dynamic> jsonMap = json.decode(jsonString);
      return PropertyReviewResponse.fromJson(jsonMap);
    } else {
      print(' Error Response: ${response.reasonPhrase}');
      throw Exception(
          'Failed to load property reviews: ${response.reasonPhrase}');
    }
  }


  ///////////////////////////////  fetchProperties API 15

  // Future<MyPropertyList> fetchProperties(String userId) async {
  //   final String baseUrl = 'https://madanvasu.in/new/apis/Api_my_property_list';
  //   final String sessionCookie = 'ci_session=983fef1799ca85556b57052de36c12985002b76a';
  //
  //   try {
  //     final uri = Uri.parse('$baseUrl/my_properties_list?user_id=$userId');
  //     final headers = {'Cookie': sessionCookie};
  //
  //     final response = await http.get(uri, headers: headers).timeout(Duration(seconds: 30));
  //
  //     if (response.statusCode == 200) {
  //       final jsonData = jsonDecode(response.body);
  //       return MyPropertyList.fromJson(jsonData);
  //     } else {
  //       throw Exception('Failed to load properties: ${response.statusCode} - ${response.reasonPhrase}');
  //     }
  //   } catch (e) {
  //     throw Exception('Error fetching properties: $e');
  //   }
  // }


  Future<MyPropertyList> fetchProperties(String userId) async {
    final String sessionCookie = 'ci_session=983fef1799ca85556b57052de36c12985002b76a';

    final url = Uri.parse(
      '${ApiEndpoints.baseUrl}${ApiEndpoints
          .my_properties_list}?user_id=$userId',
    );

    final headers = {'Cookie': sessionCookie};

    print("MyPropertyList API URL: $url");

    try {
      final response = await http.get(url, headers: headers).timeout(
          const Duration(seconds: 30));

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return MyPropertyList.fromJson(jsonData);
      } else {
        throw Exception(
            'Failed to load properties: ${response.statusCode} - ${response
                .reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Error fetching properties: $e');
    }
  }


  /////////////////////////////


  static Future<Map<String, dynamic>?> fetchContactDetails() async {
    final headers = {
      'Cookie': 'ci_session=f985237c86535f1740b72b4b830249eb1991839d',
    };

    final url = Uri.parse('${ApiEndpoints.baseUrl}${ApiEndpoints.contactus}');

    print('Contact API URL: $url');

    try {
      final request = http.Request('GET', url)
        ..headers.addAll(headers);
      final response = await request.send();

      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        return json.decode(responseData);
      } else {
        print('Failed to load contact: ${response.reasonPhrase}');
        return null;
      }
    } catch (e) {
      print('Exception in fetchContactDetails: $e');
      return null;
    }
  }

////////////////////////

  static Future<PropertyPlanDays?> fetchPlanDays() async {
    final url = Uri.parse(
        '${ApiEndpoints.baseUrl}${ApiEndpoints.propertyPlanDays}');
    print('propertyPlanDays API URL: $url');

    final headers = {
      'Cookie': 'ci_session=e120d6fb08532656fd24e7710ac5fda3238b2754',
    };

    try {
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return PropertyPlanDays.fromJson(jsonData);
      } else {
        print(' Failed to fetch plan days: ${response.reasonPhrase}');
        return null;
      }
    } catch (e) {
      print(' Exception in fetchPlanDays: $e');
      return null;
    }
  }

///////////////////

  static const Map<String, String> headers = {
    'Cookie': 'ci_session=e120d6fb08532656fd24e7710ac5fda3238b2754',
  };

  Future<String?> getPropertyPricesRaw() async {
    final url = Uri.parse('${ApiEndpoints.baseUrl}${ApiEndpoints.propertyPriceUrl}');
    print('propertyPriceUrl API URL: $url');

    try {
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        return response.body;
      } else {
        print('Error: ${response.reasonPhrase}');
        return null;
      }
    } catch (e) {
      print('Exception: $e');
      return null;
    }
  }

  //////////////////

  // static const Map<String, String> headers = {
  //   'Cookie': 'ci_session=f985237c86535f1740b72b4b830249eb1991839d',
  // };

  Future<Map<String, dynamic>?> fetchAboutUsData() async {
    final url = Uri.parse('${ApiEndpoints.baseUrl}${ApiEndpoints.aboutUsUrl}');
    print('aboutUsUrl API URL: $url');

    try {
      final request = http.Request('GET', url);
      request.headers.addAll(headers);

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        return jsonDecode(responseBody);
      } else {
        print(' Failed to load: ${response.reasonPhrase}');
        return null;
      }
    } catch (e) {
      print(' Exception in AboutUsApiService: $e');
      return null;
    }
  }

  ///////////////////

  static Future<Map<String, dynamic>?> updateUserProfile(Map<String, String> data) async {
    final url = Uri.parse('${ApiEndpoints.baseUrl}${ApiEndpoints.updateProfile}');

    print('updateProfile API URL: $url');

    const _cookie = 'ci_session=1c7a1ac6e9d64e7de9b7792e526959fb6f1ca666';

    var request = http.MultipartRequest('POST', url);
    request.fields.addAll(data);

    request.headers.addAll({'Cookie': _cookie});

    try {
      final response = await request.send();

      if (response.statusCode == 200) {
        final respStr = await response.stream.bytesToString();
        return json.decode(respStr);
      } else {
        print(' Server Error: ${response.reasonPhrase}');
        return {
          'status': false,
          'message': 'Server Error: ${response.reasonPhrase}',
        };
      }
    } catch (e) {
      print(' Exception: $e');
      return {
        'status': false,
        'message': 'Exception: $e',
      };
    }
  }

  ///////////////////////////

  static Future<String> fetchPrivacyPolicyContent() async {
    final url = Uri.parse('${ApiEndpoints.baseUrl}${ApiEndpoints.privacyPolicy}');

    print('privacyPolicy API URL: $url');

    const _cookie =
        'ci_session=14b22b25b4ec49d03cbaafdf8d607d7f56ee90de';

    final headers = {'Cookie': _cookie};

    try {
      final request = http.Request('GET', url)..headers.addAll(headers);
      final response = await request.send();

      if (response.statusCode == 200) {
        final body = await response.stream.bytesToString();
        final decoded = jsonDecode(body);

        if (decoded['status'] == true && decoded['data'].isNotEmpty) {
          return decoded['data'][0]['content_description'] ?? 'No content found.';
        } else {
          return 'No privacy policy available.';
        }
      } else {
        return 'Failed to fetch Policy: ${response.reasonPhrase}';
      }
    } catch (e) {
      return 'Error: $e';
    }
  }

  //////////////////////


  static Future<String> fetchTermsContent() async {
    final url = Uri.parse('${ApiEndpoints.baseUrl}${ApiEndpoints.termsConditions}');
    print('termsConditions API URL: $url');

    const _cookie = 'ci_session=f62dd2de6712e6747ffbd7c6b1d211a5aa82677c';

    final headers = {'Cookie': _cookie};

    try {
      final request = http.Request('GET', url)..headers.addAll(headers);
      final response = await request.send();

      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        final decoded = jsonDecode(responseBody);

        if (decoded['status'] == true && decoded['data'].isNotEmpty) {
          return decoded['data'][0]['content_description'] ?? 'No content found.';
        } else {
          return 'No terms & conditions available.';
        }
      } else {
        return 'Failed to fetch terms: ${response.reasonPhrase}';
      }
    } catch (e) {
      return 'Error: $e';
    }

  }

  //////////////////////

  // static Future<PropertyDetailsModel?> fetchPropertyDetails(String propertyId) async {
  //   final url = Uri.parse('${ApiEndpoints.baseUrl}${ApiEndpoints.propertyDetails}?property_id=$propertyId');
  //   const String _cookie = 'ci_session=5f0d9cfa80f508b281dd8f34a9666fe437af600d';
  //
  //   try {
  //     final request = http.Request('GET', url)
  //       ..headers.addAll({'Cookie': _cookie});
  //
  //     final response = await request.send();
  //
  //     if (response.statusCode == 200) {
  //       final responseBody = await response.stream.bytesToString();
  //       final decodedJson = json.decode(responseBody);
  //       return PropertyDetailsModel.fromJson(decodedJson);
  //     } else {
  //       print(' Error: ${response.reasonPhrase}');
  //       return null;
  //     }
  //   } catch (e) {
  //     print(' Exception in PropertyService: $e');
  //     return null;
  //   }
  // }


///////////////////////


  static Future<List<PropertyStatusData>> fetchPropertyStatuses() async {
    final url = Uri.parse('${ApiEndpoints.baseUrl}${ApiEndpoints.propertyStatusList}');
     const String _cookie = 'ci_session=83e2a8e600d5489f97e329ea70d52b4b17216e7f';

    final headers = {'Cookie': _cookie};

    try {
      final request = http.Request('GET', url);
      request.headers.addAll(headers);

      final response = await request.send();

      if (response.statusCode == 200) {
        final body = await response.stream.bytesToString();
        final decoded = json.decode(body);

        final status = PropertyStatus.fromJson(decoded);
        return status.data;
      } else {
        throw Exception('Failed with status: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching property statuses: $e');
    }
  }


  //////////////


  static Future<List<DistrictData>> fetchDistricts(String stateId) async {
    final url = Uri.parse('${ApiEndpoints.baseUrl}${ApiEndpoints.getDistricts}?state_id=$stateId');
    const String _cookie = 'ci_session=a04f1896c10dbdf35a7324eddc717f4c12e8fa4b';
    print('getDistricts API URL: $url');

    final headers = {'Cookie': _cookie};

    var request = http.Request('GET', url);
    request.headers.addAll(headers);

    final response = await request.send();

    if (response.statusCode == 200) {
      final jsonString = await response.stream.bytesToString();
      final jsonData = json.decode(jsonString);
      DistrictNameModel model = DistrictNameModel.fromJson(jsonData);
      return model.data;
    } else {
      throw Exception('Failed to load districts: ${response.reasonPhrase}');
    }
  }

  ///////////////////////////

  static Future<List<MandalData>> fetchMandals({
    required String stateId,
    required String districtId,
  }) async {
    final url = Uri.parse('${ApiEndpoints.baseUrl}${ApiEndpoints.getMandals}?state_id=$stateId&district_id=$districtId');
    print('getMandals API URL: $url');

    const String _cookie = 'ci_session=152b862654e76b26067650896768ba8b7d5d7afe';

    final headers = {'Cookie': _cookie};

    var request = http.Request('GET', url);
    request.headers.addAll(headers);

    final response = await request.send();

    if (response.statusCode == 200) {
      final responseBody = await response.stream.bytesToString();
      final jsonData = json.decode(responseBody);
      MandalNameModel model = MandalNameModel.fromJson(jsonData);
      return model.data;
    } else {
      throw Exception('Failed to load mandals: ${response.reasonPhrase}');
    }
  }

////////////////////

  static Future<List<StatesModelData>> fetchStates() async {
    final url = Uri.parse('${ApiEndpoints.baseUrl}${ApiEndpoints.getStates}');
     const String _cookie = 'ci_session=ecdd8d906ff24a14ffc12b0d67bf467ff6be4376';
    print('getStates API URL: $url');

    final headers = {'Cookie': _cookie};

    var request = http.Request('GET', url);
    request.headers.addAll(headers);

    final response = await request.send();

    if (response.statusCode == 200) {
      final responseBody = await response.stream.bytesToString();
      final jsonData = json.decode(responseBody);
      StatesModel model = StatesModel.fromJson(jsonData);
      return model.data;
    } else {
      throw Exception('Failed to load states: ${response.reasonPhrase}');
    }
  }
//////////////////////////

  static Future<List<VillageData>> fetchVillages({
    required String stateId,
    required String districtId,
    required String mandalId,
  }) async {
    final url = Uri.parse(
      '${ApiEndpoints.baseUrl}${ApiEndpoints.getVillages}?state_id=$stateId&district_id=$districtId&mandal_id=$mandalId',
    );
     const String _cookie = 'ci_session=152b862654e76b26067650896768ba8b7d5d7afe';
    print('getVillages API URL: $url');

    final headers = {'Cookie': _cookie};

    var request = http.Request('GET', url);
    request.headers.addAll(headers);

    final response = await request.send();

    if (response.statusCode == 200) {
      final responseBody = await response.stream.bytesToString();
      final jsonData = json.decode(responseBody);
      VillageModel model = VillageModel.fromJson(jsonData);
      return model.data;
    } else {
      throw Exception('Failed to load villages: ${response.reasonPhrase}');
    }
  }





}



