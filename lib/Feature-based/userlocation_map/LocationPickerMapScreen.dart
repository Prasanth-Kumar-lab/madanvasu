import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationPickerMapScreen extends StatefulWidget {
  @override
  _LocationPickerMapScreenState createState() => _LocationPickerMapScreenState();
}

class _LocationPickerMapScreenState extends State<LocationPickerMapScreen> {
  GoogleMapController? _controller;
  LatLng? _pickedLocation;
  Marker? _marker;

  @override
  void initState() {
    super.initState();
    _setCurrentLocation();
  }

  void _setCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    LatLng currentLatLng = LatLng(position.latitude, position.longitude);
    setState(() {
      _pickedLocation = currentLatLng;
      _marker = Marker(markerId: MarkerId('picked'), position: currentLatLng);
    });

    _controller?.animateCamera(CameraUpdate.newLatLngZoom(currentLatLng, 16));
  }

  Future<void> _confirmLocation() async {
    if (_pickedLocation == null) return;

    List<Placemark> placemarks = await placemarkFromCoordinates(
      _pickedLocation!.latitude,
      _pickedLocation!.longitude,
    );

    String address = placemarks.isNotEmpty
        ? "${placemarks[0].street}, ${placemarks[0].locality}"
        : "Selected Location";

    Get.back(result: {
      'latlng': _pickedLocation,
      'address': address,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pick Location"),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: _confirmLocation,
          )
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(
          target: LatLng(17.385044, 78.486671), // Hyderabad default
          zoom: 14,
        ),
        markers: _marker != null ? {_marker!} : {},
        onMapCreated: (controller) => _controller = controller,
        onTap: (latLng) {
          setState(() {
            _pickedLocation = latLng;
            _marker = Marker(markerId: MarkerId('picked'), position: latLng);
          });
        },
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
      ),
    );
  }
}