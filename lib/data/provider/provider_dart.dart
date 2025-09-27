import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../../Feature-based/auth/login_controller/login_controller.dart';
import '../../Feature-based/property/property_model/PropertyList_Screen.dart';
import '../../Feature-based/property/property_model/property_controller.dart';

List<SingleChildWidget> appProviders = [
  // ChangeNotifierProvider<LoginController>(
  //   create: (context) => LoginController(),
  // ),
  // Add more ChangeNotifierProviders here as needed
  // ChangeNotifierProvider<AnotherController>(
  //   create: (context) => AnotherController(),
  // ),

  // ChangeNotifierProvider(
  //   // create: (context) => PropertyController(),
  //   // child: const PropertyListScreen(),
  // ),

];
