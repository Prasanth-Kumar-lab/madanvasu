import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter/material.dart';

import 'LocationPickerMapScreen.dart';

class LocationController extends GetxController {
  var selectedLatLng = Rxn<LatLng>();
  var selectedAddress = ''.obs;

  var currentLatLng = Rxn<LatLng>();
  var currentAddress = ''.obs;

  Future<void> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Get.snackbar("Location", "Enable GPS to fetch location.");
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever ||
          permission == LocationPermission.denied) {
        // Get.snackbar("Permission", "Location permission denied.");   ///Balu
        return;
      }
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    currentLatLng.value = LatLng(position.latitude, position.longitude);

    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    if (placemarks.isNotEmpty) {
      Placemark place = placemarks[0];

      String fullAddress = '''
   Location Details:
  ➤ Street: ${place.street}
  ➤ Village/Area: ${place.subLocality}
  ➤ Mandal (Sub-Administrative Area): ${place.subAdministrativeArea}
  ➤ District (Locality): ${place.locality}
  ➤ State: ${place.administrativeArea}
  ➤ Country: ${place.country}
  ➤ Postal Code: ${place.postalCode}
  ➤ Latitude: ${position.latitude}
  ➤ Longitude: ${position.longitude}
''';

      currentAddress.value =
      "${place.street}, ${place.locality}, ${place.administrativeArea}";

      print(fullAddress);

      if (selectedLatLng.value == null) {
        selectedLatLng.value = currentLatLng.value;
        selectedAddress.value = currentAddress.value;
      }
    } else {
      currentAddress.value = "Unknown location";
      print("Could not retrieve placemark.");
    }
  }

  Future<void> selectLocationFromMap(BuildContext context) async {
    final result = await Get.to(() => LocationPickerMapScreen());

    if (result != null && result is Map<String, dynamic>) {
      selectedLatLng.value = result['latlng'];
      selectedAddress.value = result['address'];
    }
  }

  String get displayAddress {
    if (selectedAddress.value.isNotEmpty) {
      return selectedAddress.value;
    } else if (currentAddress.value.isNotEmpty) {
      return currentAddress.value;
    } else {
      return "Fetching location...";
    }
  }
}
