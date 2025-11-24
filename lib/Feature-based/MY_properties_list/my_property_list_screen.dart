import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:madhanvasu_app/utils/shared_pref_helper.dart';
import '../../../app/configuration/themes/app_colors.dart';
import '../SavedProperties/saved_properties_controller.dart';
import '../home/FeaturedPoperties/featured_property_card.dart';
import '../post_property_feature/customer_property_plan/customer_plan_controller.dart';
import '../post_property_feature/post_property_screen.dart';
import '../post_property_feature/property_plan_days/property_plan_day_controller.dart';
import '../property_details/property_details.dart';
import 'my_property_list_controller.dart';
import '../../../data/Api_services/user_api_services.dart';

// ============================================================
// 1. RENEWAL CONTROLLER (calls renew API after payment)
// ============================================================
class RenewalController extends GetxController {
  Future<bool> submitCustomerPlan({
    required String propertyId,
    required String userId,
    required String planDaysId,
  }) async {
    var headers = {
      'Cookie': 'ci_session=6208d840ef28921d0843158cf3babef58fd8ad45'
    };

    var request = http.MultipartRequest(
      'POST',
      Uri.parse(
          'https://madanvasu.in/new/apis/Api_property_plan/renew_property_plan'),
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
          Get.snackbar(
            'Renewed!',
            result['message'] ?? 'Property plan renewed successfully!',
            backgroundColor: Colors.green,
            colorText: Colors.white,
            duration: const Duration(seconds: 4),
          );
          return true;
        } else {
          Get.snackbar(
            'Failed',
            result['message'] ?? 'Failed to renew plan',
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
          return false;
        }
      } else {
        Get.snackbar(
          'Error',
          response.reasonPhrase ?? 'Server error',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return false;
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Network error: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    }
  }
}

// ============================================================
// 2. GLOBAL CONTROLLERS
// ============================================================
final propertyPlanController = Get.put(PropertyPlanController());
final renewalController = Get.put(RenewalController());


mixin RazorpayMixin<T extends StatefulWidget> on State<T> {
  late Razorpay _razorpay;
  String? userId;

  String? _pendingPropertyId;
  String? _pendingUserId;
  String? _pendingPlanDaysId;

  String? username;
  String? email;
  String? mobileNumber;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

    _loadUserData(); // preload user details
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  Future<void> _loadUserData() async {
    userId = await SharedPrefHelper.getUserData('id');
    username = await SharedPrefHelper.getUserData('personName') ?? 'User';
    email = await SharedPrefHelper.getUserData('email') ?? '';
    mobileNumber = await SharedPrefHelper.getUserData('mobileNumber') ?? '';
  }

  // ── Payment Handlers ─────────────────────────────
  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    Fluttertoast.showToast(msg: "Payment ID: ${response.paymentId}");

    if (_pendingPropertyId == null ||
        _pendingUserId == null ||
        _pendingPlanDaysId == null) {
      Get.snackbar(
        'Error',
        'Renewal data missing',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      _clearPending();
      return;
    }

    final success = await renewalController.submitCustomerPlan(
      propertyId: _pendingPropertyId!,
      userId: _pendingUserId!,
      planDaysId: _pendingPlanDaysId!,
    );

    if (success) {
      Get.offAllNamed('/home');
    }

    _clearPending();
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(msg: "Payment Failed: ${response.message}");
    Get.snackbar(
      'Payment Failed',
      response.message ?? 'Try again',
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
    _clearPending();
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(msg: "Wallet: ${response.walletName}");
  }

  void _clearPending() {
    _pendingPropertyId = null;
    _pendingUserId = null;
    _pendingPlanDaysId = null;
  }


  Future<void> startRazorpayPayment({
    required String amount,
    required String propertyId,
    required String userId,
    required String planDaysId,
  }) async {
    _pendingPropertyId = propertyId;
    _pendingUserId = userId;
    _pendingPlanDaysId = planDaysId;

    // Ensure user data is loaded
    if (username == null || email == null || mobileNumber == null) {
      await _loadUserData();
    }

    final options = {
      'key': 'rzp_test_YUG2xn1ehSty3E',
      'amount': (double.tryParse(amount) ?? 0) * 100, // Razorpay expects paise
      'name': username ?? 'User',
      'description': 'Property Plan Renewal',
      'prefill': {
        'contact': mobileNumber ?? '',
        'email': email ?? '',
      },
      'theme': {'color': '#e57c42'},
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to open payment: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      _clearPending();
    }
  }
}


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
          Get.snackbar('Info', result['message'] ?? 'Already in favorites',
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

// ============================================================
// 5. SHOW PLANS DIALOG + RAZORPAY (calls correct plan-days API)
// ============================================================
void showPlansDialog(BuildContext context, String propertyId,
    RazorpayMixin razorpayMixin) {
  final selectedPlanId = RxnString();
  final selectedPlan = Rxn<dynamic>();

  // ---- FETCH PLAN DAYS FROM YOUR API ----
  propertyPlanController.fetchPlanDays(); // <-- this now calls the correct URL

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => Obx(() {
      // ----- LOADING -----
      if (propertyPlanController.isLoading.value) {
        return const AlertDialog(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
          content: Center(
              child: CircularProgressIndicator(color: AppColors.secondary)),
        );
      }

      final plans = propertyPlanController.planDaysList;

      // ----- NO PLANS -----
      if (plans.isEmpty) {
        return AlertDialog(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
          title: const Text('No plans available'),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: const Text('OK',
                  style: TextStyle(color: AppColors.secondary)),
            ),
          ],
        );
      }

      // ----- PLAN LIST -----
      return AlertDialog(
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
        title: const Text('Select Plan',
            style: TextStyle(color: AppColors.primary)),
        content: SizedBox(
          width: double.maxFinite,
          height: 300,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: plans.length,
            itemBuilder: (_, i) {
              final plan = plans[i];
              return Obx(() => Card(
                elevation: 2,
                margin: const EdgeInsets.symmetric(vertical: 4),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                child: RadioListTile<String>(
                  title: Text(
                    '${plan.planDays} days - ₹${plan.totalPrice}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('${plan.planDays} days validity'),
                  value: plan.id!,
                  groupValue: selectedPlanId.value,
                  activeColor: AppColors.secondary,
                  onChanged: (v) {
                    selectedPlanId.value = v;
                    selectedPlan.value = plan;
                  },
                ),
              ));
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel',
                style: TextStyle(color: AppColors.secondary)),
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

              Get.back(); // close dialog

              // ---- OPEN RAZORPAY (prefill from SharedPref) ----
              await razorpayMixin.startRazorpayPayment(
                amount: selectedPlan.value.totalPrice.toString(),
                propertyId: propertyId,
                userId: userId,
                planDaysId: selectedPlanId.value!,
              );
            },
            child: const Text('Proceed to Pay',
                style: TextStyle(color: AppColors.secondary)),
          ),
        ],
      );
    }),
  );
}

// ============================================================
// 6. MY PROPERTY LIST SCREEN
// ============================================================
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
      secondaryTextColor:
      args['secondaryTextColor'] ?? const Color(0xFFe4b201),
    );
  }

  @override
  State<MyPropertyListScreen> createState() => _MyPropertyListScreenState();
}

class _MyPropertyListScreenState extends State<MyPropertyListScreen>
    with RazorpayMixin<MyPropertyListScreen> {
  final MyPropertyListController controller =
  Get.put(MyPropertyListController(''));
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
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, size: 26),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            Expanded(
              child: isLoading
                  ? Center(
                  child: CircularProgressIndicator(
                      color: widget.accentColor))
                  : Obx(() {
                if (controller.isLoading.value) {
                  return Center(
                      child: CircularProgressIndicator(
                          color: widget.accentColor));
                }
                if (controller.errorMessage.isNotEmpty) {
                  return Center(
                      child: Text(controller.errorMessage.value,
                          style: TextStyle(
                              color: widget.secondaryTextColor)));
                }
                if (controller.properties.isEmpty) {
                  return Center(
                      child: Text('No properties found.',
                          style: TextStyle(
                              color: widget.secondaryTextColor)));
                }

                return RefreshIndicator(
                  onRefresh: controller.fetchProperties,
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 4),
                    physics: const BouncingScrollPhysics(),
                    itemCount: controller.properties.length,
                    itemBuilder: (context, i) {
                      final property = controller.properties[i];

                      final location = [
                        property.streetName ?? '',
                        property.villageId ?? '',
                        property.mandalId ?? '',
                        property.pinCode ?? '',
                      ].where((e) => e.trim().isNotEmpty).join(', ');

                      return FeaturedPropertyCard(
                        propertyId: property.id ?? '',
                        title: property.title ?? 'No Title',
                        price: property.price != null
                            ? '₹${property.price} / month'
                            : 'N/A',
                        location: location,
                        planStartDate: property.planStartDate ?? '',
                        planExpiryDate: property.planExpiryDate ?? '',
                        isHorizontal: false,
                        primaryColor: widget.primaryColor,
                        accentColor: Colors.green,
                        cardColor: widget.cardColor,
                        secondaryTextColor: widget.secondaryTextColor,
                        onViewDetails: () {
                          Get.to(() => PropertyDetailsScreen(
                            id: property.id ?? '',
                            propertyName: property.title ?? '',
                            location: location,
                            price: property.price != null
                                ? '₹${property.price}'
                                : '',
                            description: property
                                .floorPlanDescription ??
                                "No Description",
                          ));
                        },
                        onUpdatePlan: () {
                          showPlansDialog(
                              context, property.id ?? '', this);
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