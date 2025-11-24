import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:madhanvasu_app/utils/shared_pref_helper.dart';
import '../../../app/configuration/themes/app_colors.dart';
import '../../../data/Api_services/user_api_services.dart';
import '../../MY_properties_list/my_property_list_controller.dart';
import '../../SavedProperties/saved_properties_controller.dart';
import '../../property_details/property_details.dart';

class PropertyPlanDays {
  bool? status;
  List<PlanDayData>? data;

  PropertyPlanDays({this.status, this.data});

  PropertyPlanDays.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <PlanDayData>[];
      json['data'].forEach((v) {
        data!.add(PlanDayData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonData = <String, dynamic>{};
    jsonData['status'] = status;
    if (data != null) {
      jsonData['data'] = data!.map((v) => v.toJson()).toList();
    }
    return jsonData;
  }
}

class PlanDayData {
  String? id;
  String? planDays;
  String? activeStatus;
  String? perDayCharge;
  int? totalPrice;
  String? formattedPrice;
  String? description;

  PlanDayData({
    this.id,
    this.planDays,
    this.activeStatus,
    this.perDayCharge,
    this.totalPrice,
    this.formattedPrice,
    this.description,
  });

  PlanDayData.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    planDays = json['plan_days']?.toString();
    activeStatus = json['active_status'];
    perDayCharge = json['per_day_charge'];
    totalPrice = json['total_price'] is int
        ? json['total_price']
        : int.tryParse(json['total_price']?.toString() ?? '');
    formattedPrice = json['formatted_price'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonData = <String, dynamic>{};
    jsonData['id'] = id;
    jsonData['plan_days'] = planDays;
    jsonData['active_status'] = activeStatus;
    jsonData['per_day_charge'] = perDayCharge;
    jsonData['total_price'] = totalPrice;
    jsonData['formatted_price'] = formattedPrice;
    jsonData['description'] = description;
    return jsonData;
  }
}

class PropertyPlanController extends GetxController {
  var isLoading = true.obs;
  var planDaysList = <PlanDayData>[].obs;

  @override
  void onInit() {
    fetchPlanDays();
    super.onInit();
  }

  void fetchPlanDays() async {
    isLoading.value = true;

    final planDaysModel = await ApiService.fetchPlanDays();

    if (planDaysModel != null && planDaysModel.data != null) {
      planDaysList.assignAll(planDaysModel.data!);
    } else {
      Get.snackbar("Error", "Failed to load plan days");
      print('PropertyPlanController → Failed to load plans');
    }

    isLoading.value = false;
  }
}

// ──────────────────────────────────────
//  CUSTOMER PLAN SUBMIT CONTROLLER
// ──────────────────────────────────────
class CustomerPlanController extends GetxController {
  Future<void> submitCustomerPlan({
    required String propertyId,
    required String userId,
    required String planDaysId,
  }) async {
    var headers = {
      'Cookie': 'ci_session=6208d840ef28921d0843158cf3babef58fd8ad45'
    };

    var request = http.MultipartRequest(
      'POST',
      Uri.parse('https://madanvasu.in/new/apis/Api_property_plan/renew_property_plan'),
    );

    request.fields.addAll({
      'property_id': propertyId,
      'user_id': userId,
      'plan_days_id': planDaysId,
      'active': 'Active'
    });

    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        String resp = await response.stream.bytesToString();
        final result = jsonDecode(resp);
        if (result['status'] == true) {
          Get.snackbar('Success', result['message'] ?? 'Plan updated successfully',
              backgroundColor: Colors.green, colorText: Colors.white);
        } else {
          Get.snackbar('Failed', result['message'] ?? 'Failed to update plan',
              backgroundColor: Colors.red, colorText: Colors.white);
        }
      } else {
        Get.snackbar('Error', response.reasonPhrase ?? 'Server error',
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar('Error', 'Network error: $e',
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }
}

// Initialize Controllers
final propertyPlanController = Get.put(PropertyPlanController());
final customerPlanController = Get.put(CustomerPlanController());

// ──────────────────────────────────────
//  FEATURED PROPERTY CARD
// ──────────────────────────────────────
class FeaturedPropertyCard extends StatefulWidget {
  final String propertyId;
  final String title;
  final String price;
  final String location;
  final bool isHorizontal;
  final Color primaryColor;
  final Color accentColor;
  final Color cardColor;
  final Color secondaryTextColor;
  final VoidCallback onViewDetails;
  final VoidCallback onUpdatePlan;
  final String planStartDate;
  final String planExpiryDate;

  const FeaturedPropertyCard({
    super.key,
    required this.propertyId,
    required this.title,
    required this.price,
    required this.location,
    required this.isHorizontal,
    required this.primaryColor,
    required this.accentColor,
    required this.cardColor,
    required this.secondaryTextColor,
    required this.onViewDetails,
    required this.onUpdatePlan,
    required this.planStartDate,
    required this.planExpiryDate,
  });

  @override
  State<FeaturedPropertyCard> createState() => _FeaturedPropertyCardState();
}

class _FeaturedPropertyCardState extends State<FeaturedPropertyCard> {
  final favoriteController = Get.find<FavoritePropertiesController>();
  String? userId;

  @override
  void initState() {
    super.initState();
    loadUserId();
  }

  Future<void> loadUserId() async {
    final id = await SharedPrefHelper.getUserData('id');
    setState(() => userId = id);
  }

  Future<void> handleFavoriteTap() async {
    if (userId == null || userId!.isEmpty) {
      Get.snackbar('Error', 'Please login to manage favorites',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      return;
    }

    if (widget.propertyId.isEmpty) {
      Get.snackbar('Error', 'Invalid property ID',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      return;
    }

    try {
      final isFav = favoriteController.isFavorite(widget.propertyId);
      if (isFav) {
        final success = await favoriteController.removeFavorite(widget.propertyId);
        if (success) {
          Get.snackbar('Removed', 'Property removed from favorites',
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.orange,
              colorText: Colors.white);
        } else {
          Get.snackbar('Error', 'Failed to remove favorite',
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.red,
              colorText: Colors.white);
        }
      } else {
        final result = await ApiService.addFavoriteProperty(
          userId: userId!,
          propertyId: widget.propertyId,
        );

        if (result['status'] == true) {
          favoriteController.favoriteIds.add(widget.propertyId);
          Get.snackbar('Success', result['message'] ?? 'Added to favorites',
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.green,
              colorText: Colors.white);
        } else if ((result['message'] ?? '').contains('Already Added')) {
          Get.snackbar('Info', result['message'] ?? 'Property already in favorites',
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.blueGrey,
              colorText: Colors.white);
        } else {
          Get.snackbar('Error', result['message'] ?? 'Failed to add favorite',
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.red,
              colorText: Colors.white);
        }
      }
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 230,
      width: widget.isHorizontal ? 240 : double.infinity,
      margin: EdgeInsets.only(right: widget.isHorizontal ? 16 : 0, bottom: 16),
      decoration: BoxDecoration(
        color: widget.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: widget.primaryColor, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: widget.primaryColor.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: widget.primaryColor,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              widget.location,
              style: const TextStyle(color: Colors.black87, fontSize: 14),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            Text(
              widget.price,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: widget.accentColor,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Plan Start: ${widget.planStartDate}',
              style: const TextStyle(fontSize: 12, color: Colors.black87),
            ),
            Text(
              'Plan Expiry: ${widget.planExpiryDate}',
              style: const TextStyle(fontSize: 12, color: Colors.black87),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: widget.onViewDetails,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFe57c42),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: const Text(
                      'View Details',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: widget.onUpdatePlan,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: const Text(
                      'Update Plan',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                Obx(() => IconButton(
                  icon: Icon(
                    favoriteController.isFavorite(widget.propertyId)
                        ? Icons.favorite
                        : Icons.favorite_border,
                  ),
                  color: const Color(0xFFe57c42),
                  onPressed: handleFavoriteTap,
                )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ──────────────────────────────────────
//  DIALOG – SHOW PLANS (Typed + Console Print)
// ──────────────────────────────────────
void showPlansDialog(BuildContext context, String propertyId) {
  final selectedPlanId = RxnString();
  final selectedPlan = Rxn<PlanDayData>();

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => Obx(() {
      // Loading
      if (propertyPlanController.isLoading.value) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          content: const Center(
            child: CircularProgressIndicator(color: AppColors.secondary),
          ),
        );
      }

      final plans = propertyPlanController.planDaysList;

      // No Plans
      if (plans.isEmpty) {
        const msg = 'No plans available';
        print('showPlansDialog → $msg'); // Console
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text(msg),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: const Text('OK', style: TextStyle(color: AppColors.secondary)),
            ),
          ],
        );
      }

      // Show Plans
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Select Plan', style: TextStyle(color: AppColors.primary)),
        content: SizedBox(
          width: double.maxFinite,
          height: 300,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: plans.length,
            itemBuilder: (context, index) {
              final plan = plans[index];
              return Obx(() => Card(
                elevation: 2,
                margin: const EdgeInsets.symmetric(vertical: 4),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: RadioListTile<String>(
                  title: Text(
                    '${plan.planDays} days - ${plan.formattedPrice}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(plan.description ?? ''),
                  value: plan.id!,
                  groupValue: selectedPlanId.value,
                  onChanged: (value) {
                    selectedPlanId.value = value;
                    selectedPlan.value = plan;
                  },
                  activeColor: AppColors.secondary,
                ),
              ));
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel', style: TextStyle(color: AppColors.secondary)),
          ),
          TextButton(
            onPressed: () async {
              if (selectedPlanId.value == null) {
                Get.snackbar('Error', 'Please select a plan',
                    backgroundColor: Colors.red, colorText: Colors.white);
                return;
              }

              final userId = await SharedPrefHelper.getUserData('id');
              if (userId == null || userId.isEmpty) {
                Get.snackbar('Error', 'User not logged in',
                    backgroundColor: Colors.red, colorText: Colors.white);
                return;
              }

              Get.back(); // Close dialog

              await customerPlanController.submitCustomerPlan(
                propertyId: propertyId,
                userId: userId,
                planDaysId: selectedPlanId.value!,
              );

              if (selectedPlan.value != null) {
                _startRazorpayPayment(selectedPlan.value!.totalPrice.toString());
              }
            },
            child: const Text('Proceed', style: TextStyle(color: AppColors.secondary)),
          ),
        ],
      );
    }),
  );
}

// Razorpay Dummy
void _startRazorpayPayment(String amount) {
  print('Initiating Razorpay payment: ₹$amount');
  Get.snackbar('Payment', 'Starting payment for ₹$amount...',
      backgroundColor: Colors.blue, colorText: Colors.white);
}

// ──────────────────────────────────────
//  MY PROPERTY LIST SCREEN
// ──────────────────────────────────────
class MyPropertyListScreen extends StatefulWidget {
  final Color primaryColor;
  final Color accentColor;
  final Color cardColor;
  final Color secondaryTextColor;

  const MyPropertyListScreen({
    Key? key,
    required this.primaryColor,
    required this.accentColor,
    required this.cardColor,
    required this.secondaryTextColor,
  }) : super(key: key);

  factory MyPropertyListScreen.fromArguments() {
    final args = Get.arguments ?? {};
    return MyPropertyListScreen(
      primaryColor: args['primaryColor'] ?? const Color(0xFFe4b201),
      accentColor: args['accentColor'] ?? const Color(0xFF757575),
      cardColor: args['cardColor'] ?? Colors.white,
      secondaryTextColor: args['secondaryTextColor'] ?? const Color(0xFFe4b201),
    );
  }

  @override
  State<MyPropertyListScreen> createState() => _MyPropertyListScreenState();
}

class _MyPropertyListScreenState extends State<MyPropertyListScreen> {
  final MyPropertyListController controller = Get.put(MyPropertyListController(''));
  String? userId;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadUserId();
  }

  Future<void> loadUserId() async {
    final id = await SharedPrefHelper.getUserData('id');
    if (id != null && id.isNotEmpty) {
      setState(() {
        userId = id;
        isLoading = false;
      });
      controller.updateUserId(id);
      controller.fetchProperties();
    } else {
      setState(() => isLoading = false);
      Get.snackbar('Error', 'User ID not found. Please login again.',
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              widget.primaryColor.withOpacity(0.1),
              widget.cardColor.withOpacity(0.1),
            ],
          ),
        ),
        child: Column(
          children: [
            AppBar(
              backgroundColor: widget.cardColor,
              elevation: 0,
              title: const Text(
                'My Properties',
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
              ),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, size: 26),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            Expanded(
              child: isLoading
                  ? Center(child: CircularProgressIndicator(color: widget.accentColor))
                  : Obx(() {
                if (controller.isLoading.value) {
                  return Center(child: CircularProgressIndicator(color: widget.accentColor));
                } else if (controller.errorMessage.isNotEmpty) {
                  return Center(
                    child: Text(controller.errorMessage.value,
                        style: TextStyle(color: widget.secondaryTextColor)),
                  );
                } else if (controller.properties.isEmpty) {
                  return Center(
                    child: Text('No properties found.',
                        style: TextStyle(color: widget.secondaryTextColor)),
                  );
                }

                return RefreshIndicator(
                  onRefresh: () => controller.fetchProperties(),
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    physics: const BouncingScrollPhysics(),
                    itemCount: controller.properties.length,
                    itemBuilder: (context, index) {
                      final property = controller.properties[index];

                      final location = [
                        property.streetName ?? '',
                        property.villageId ?? '',
                        property.mandalId ?? '',
                        property.pinCode ?? '',
                      ].where((e) => e.trim().isNotEmpty).join(', ');

                      return FeaturedPropertyCard(
                        title: property.title ?? 'No Title',
                        price: property.price != null ? '₹${property.price} / month' : 'N/A',
                        location: location,
                        planStartDate: property.planStartDate ?? '',
                        planExpiryDate: property.planExpiryDate ?? '',
                        isHorizontal: false,
                        primaryColor: widget.primaryColor,
                        accentColor: Colors.green,
                        cardColor: widget.cardColor,
                        secondaryTextColor: widget.secondaryTextColor,
                        propertyId: property.id ?? '',
                        onViewDetails: () {
                          Get.to(() => PropertyDetailsScreen(
                            id: property.id ?? '',
                            propertyName: property.title ?? '',
                            location: location,
                            price: property.price != null ? '₹${property.price}' : '',
                            description: property.floorPlanDescription ?? "No Description",
                          ));
                        },
                        onUpdatePlan: () {
                          showPlansDialog(context, property.id ?? '');
                        },
                      );
                    },
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}