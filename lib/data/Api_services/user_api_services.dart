import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../Feature-based/MY_properties_list/my_properties_list_model.dart';
import '../../Feature-based/Reviews/All_Reviews_list/List_Reviews_model.dart';
import '../../Feature-based/SavedProperties/saved_properties_model.dart';
import '../../Feature-based/auth/loging_model/login_model.dart';
import '../../Feature-based/categorys/categorys_model/categorys_model.dart';
// import '../../Feature-based/home/categorys/categorys_model/categorys_model.dart';
import '../../Feature-based/home/FeaturedPoperties/FeaturedProperties_model.dart';
import '../../Feature-based/property_details/Property_details_model.dart';
import '../../app/configuration/ themes/api_end_points.dart';
import '../../utils/shared_pref_helper.dart';

class ApiService {

  ///////////////// LOGIN API

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



  ////////////////// REGISTER API

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
      var url = Uri.parse('${ApiEndpoints.baseUrl}${ApiEndpoints.registerUser}');
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


//////////////////////////////////////

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

////////////under constracter


  Future<PropertiesDataWrapper?> PropertiesWrapper() async {
    final Map<String, String> _headers = {
      'Cookie': 'ci_session=3fb359700b5bfe52ced1fc876f9390b37aee9b0b',
    };

    try {
      final uri = Uri.parse('${ApiEndpoints.baseUrl}${ApiEndpoints.propertieslist_Bystatus}');
      final request = http.Request('GET', uri)..headers.addAll(_headers);

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

///////////////////////Available_PropertiesWrapper


  Future<PropertiesDataWrapper?> Available_PropertiesWrapper() async {
    final Map<String, String> _headers = {
      'Cookie': 'ci_session=3fb359700b5bfe52ced1fc876f9390b37aee9b0b',
    };

    try {
      final uri = Uri.parse('${ApiEndpoints.baseUrl}${ApiEndpoints.Available_propertieslist}');
      final request = http.Request('GET', uri)..headers.addAll(_headers);

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

///////////////////////////////////Rented_PropertiesWrapper


  Future<PropertiesDataWrapper?> Rented_PropertiesWrapper() async {
    final Map<String, String> _headers = {
      'Cookie': 'ci_session=3fb359700b5bfe52ced1fc876f9390b37aee9b0b',
    };

    try {
      final uri = Uri.parse('${ApiEndpoints.baseUrl}${ApiEndpoints.Rented_propertieslist}');
      final request = http.Request('GET', uri)..headers.addAll(_headers);

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

  ////////////////////////

  Future<PropertiesDataWrapper?> Sold_PropertiesWrapper() async {
    final Map<String, String> _headers = {
      'Cookie': 'ci_session=3fb359700b5bfe52ced1fc876f9390b37aee9b0b',
    };

    try {
      final uri = Uri.parse('${ApiEndpoints.baseUrl}${ApiEndpoints.sold_propertieslist}');
      final request = http.Request('GET', uri)..headers.addAll(_headers);

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

  ////////////////////////////////////


  Future<PropertiesDataWrapper?> categorys_based_on_Properties() async {
    final Map<String, String> _headers = {
      'Cookie': 'ci_session=3fb359700b5bfe52ced1fc876f9390b37aee9b0b',
    };

    try {
      final uri = Uri.parse('${ApiEndpoints.baseUrl}${ApiEndpoints.categorys_based_on_Properties}');
      final request = http.Request('GET', uri)..headers.addAll(_headers);

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


  //////////////////////////////



  Future<PropertyDetailsModel?> fetchPropertyDetails(String propertyId) async {
    final String baseUrl = 'https://madanvasu.in/new/apis/Api_properties';

    final url = Uri.parse('$baseUrl/get_property_details?property_id=$propertyId');

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
        print('❌ Error: ${response.reasonPhrase}');
        return null;
      }
    } catch (e) {
      print('❗ Exception caught in repository: $e');
      return null;
    }
  }



  ////////////////////////////////// add favvorite

  static Future<Map<String, dynamic>> addFavoriteProperty({
    required String userId,
    required String propertyId,
  }) async {
    var headers = {
      'Cookie': 'ci_session=edcc00a59e3f10a94343131ad0ffd952789c92c1',
    };

    var request = http.MultipartRequest(
      'POST',
      Uri.parse(
          'https://madanvasu.in/new/apis/Api_favorite_properties/add_favorite_property'),
    );

    request.fields.addAll({
      'user_id': userId,
      'property_id': propertyId,
    });

    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();

      String responseData = await response.stream.bytesToString();

      if (response.statusCode == 201 || response.statusCode == 200) {
        print("Success: $responseData");
        return jsonDecode(responseData); // Return the parsed response
      } else {
        print("Error: ${response.reasonPhrase}");
        return {
          'status': false,
          'message': 'Failed with status code: ${response.statusCode}'
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

  static Future<void> removeFavoriteProperty({
    required String userId,
    required String propertyId,
  }) async {
    var headers = {
      'Cookie': 'ci_session=edcc00a59e3f10a94343131ad0ffd952789c92c1',
    };

    var request = http.MultipartRequest(
      'POST',
      Uri.parse('https://madanvasu.in/new/apis/Api_favorite_properties/remove_favourite_property'),
    );

    request.fields.addAll({
      'user_id': userId,
      'property_id': propertyId,
    });

    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 201 || response.statusCode == 200) {
        String responseData = await response.stream.bytesToString();
        print("Success: $responseData");
      } else {
        print("Error: ${response.reasonPhrase}");
      }
    } catch (e) {
      print("Exception: $e");
    }
  }


  ///////////////////////////////////////// fetch  fav vorite items

  Future<FavoritePropertiesResponse> fetchFavoriteProperties(String userId) async {
    var headers = {
      'Cookie': 'ci_session=3802ff23a50e93a76844d3fee7cdeb3c34d0c66c',
    };

    var url = Uri.parse(
        'https://madanvasu.in/new/apis/Api_favorite_properties/user_favorite_properties_list?user_id=$userId');

    var request = http.Request('GET', url);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String jsonString = await response.stream.bytesToString();
      Map<String, dynamic> jsonMap = json.decode(jsonString);
      return FavoritePropertiesResponse.fromJson(jsonMap);
    } else {
      throw Exception('Failed to load data: ${response.reasonPhrase}');
    }
  }

  ////////////////----- submitReview


  static Future<String> submitReview({
    required String reviewText,
    required String propertyId,
    required String userId,
  }) async {
    try {
      var headers = {
        'Cookie': 'ci_session=a0b0251eb18f24f7b7991eab66c87e7085ee2c66'
      };

      var request = http.MultipartRequest(
        'POST',
        Uri.parse('https://madanvasu.in/new/apis/Api_property_reviews/add_property_review'),
      );

      request.fields.addAll({
        'property_id': propertyId,
        'user_id': userId,
        'review_data': reviewText,
      });

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 201 || response.statusCode == 200) {
        return await response.stream.bytesToString();
      } else {
        throw Exception('Failed to submit review: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Error submitting review: $e');
    }
  }

  //////////////////////// List_reviews


  Future<PropertyReviewResponse> fetchPropertyReviews(String propertyId) async {
    var headers = {
      'Cookie': 'ci_session=a0b0251eb18f24f7b7991eab66c87e7085ee2c66',
    };

    var url = Uri.parse(
      'https://madanvasu.in/new/apis/Api_property_reviews/user_property_reviews_list?property_id=$propertyId',
    );

    print('Request URL: $url');

    var request = http.Request('GET', url);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    print('Response Status Code: ${response.statusCode}');

    if (response.statusCode == 200) {
      String jsonString = await response.stream.bytesToString();

      print('Response Body: $jsonString');

      Map<String, dynamic> jsonMap = json.decode(jsonString);
      return PropertyReviewResponse.fromJson(jsonMap);
    } else {
      print('Error Response: ${response.reasonPhrase}');
      throw Exception('Failed to load data: ${response.reasonPhrase}');
    }
  }

  ///////////////////////////////

  Future<MyPropertyList> fetchProperties(String userId) async {
    final String baseUrl = 'https://madanvasu.in/new/apis/Api_my_property_list';
    final String sessionCookie = 'ci_session=983fef1799ca85556b57052de36c12985002b76a';

    try {
      final uri = Uri.parse('$baseUrl/my_properties_list?user_id=$userId');
      final headers = {'Cookie': sessionCookie};

      final response = await http.get(uri, headers: headers).timeout(Duration(seconds: 30));

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return MyPropertyList.fromJson(jsonData);
      } else {
        throw Exception('Failed to load properties: ${response.statusCode} - ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Error fetching properties: $e');
    }
  }






}





