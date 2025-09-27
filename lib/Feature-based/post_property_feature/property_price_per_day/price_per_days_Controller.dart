import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:madhanvasu_app/Feature-based/post_property_feature/property_price_per_day/price_per_days_modle.dart';

class PropertyPriceController {
  final String apiUrl =
      'https://madanvasu.in/new/apis/Api_property_plan/get_property_price_per_days';

  Future<PropertyPricePerDay?> fetchPropertyPrices() async {
    var headers = {
      'Cookie': 'ci_session=e120d6fb08532656fd24e7710ac5fda3238b2754',
    };

    try {
      var response = await http.get(Uri.parse(apiUrl), headers: headers);

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return PropertyPricePerDay.fromJson(jsonData);
      } else {
        print('Error: ${response.reasonPhrase}');
        return null;
      }
    } catch (e) {
      print('Exception: $e');
      return null;
    }
  }
}
