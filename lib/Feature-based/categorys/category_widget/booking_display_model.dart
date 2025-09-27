class BookingResponseModel {
  final String responseCode;
  final String message;
  final BookingContent content;
  final List<dynamic> errors;

  BookingResponseModel({
    required this.responseCode,
    required this.message,
    required this.content,
    required this.errors,
  });

  factory BookingResponseModel.fromJson(Map<String, dynamic> json) {
    return BookingResponseModel(
      responseCode: json['response_code'],
      message: json['message'],
      content: BookingContent.fromJson(json['content']),
      errors: json['errors'] ?? [],
    );
  }
}

class BookingContent {
  final List<BookingData> bookings;
  final bool showbookings;

  BookingContent({
    required this.bookings,
    required this.showbookings,
  });

  factory BookingContent.fromJson(Map<String, dynamic> json) {
    return BookingContent(
      bookings: (json['bookings'] as List)
          .map((b) => BookingData.fromJson(b))
          .toList(),
      showbookings: json['showbookings'],
    );
  }
}

class BookingData {
  final String id;
  final int readableId;
  final String customerId;
  final String providerId;
  final String zoneId;
  final String bookingStatus;
  final int isPaid;
  final String paymentMethod;
  final String transactionId;
  final double totalBookingAmount;
  final double totalTaxAmount;
  final double totalDiscountAmount;
  final String serviceSchedule;
  final String slot;
  final String serviceAddressId;
  final String serviceVehicleDetailsId;
  final String createdAt;
  final String updatedAt;
  final String categoryId;
  final String subCategoryId;
  final String? planId;
  final String? startDate;
  final String? endDate;
  final String servicemanId;
  final double totalCampaignDiscountAmount;
  final double totalCouponDiscountAmount;
  final String? couponCode;
  final int isChecked;
  final double additionalCharge;
  final double additionalTaxAmount;
  final double additionalDiscountAmount;
  final double additionalCampaignDiscountAmount;
  final String removedCouponAmount;
  final String? evidencePhotos;
  final String bookingOtp;
  final int isGuest;
  final int isVerified;
  final double extraFee;
  final double totalReferralDiscountAmount;
  final int isRepeated;
  final String? assignedBy;
  final String serviceLocation;
  final String serviceAddressLocation;
  final dynamic serviceData;
  final List<dynamic> repeats;
  final List<dynamic> evidencePhotosFullPath;
  final BookingSubCategory subCategory;
  final BookingVehicle vehicle;
  final List<BookingOccurrence> bookingOccurrences;
  final List<BookingDetail> detail;

  BookingData({
    required this.id,
    required this.readableId,
    required this.customerId,
    required this.providerId,
    required this.zoneId,
    required this.bookingStatus,
    required this.isPaid,
    required this.paymentMethod,
    required this.transactionId,
    required this.totalBookingAmount,
    required this.totalTaxAmount,
    required this.totalDiscountAmount,
    required this.serviceSchedule,
    required this.slot,
    required this.serviceAddressId,
    required this.serviceVehicleDetailsId,
    required this.createdAt,
    required this.updatedAt,
    required this.categoryId,
    required this.subCategoryId,
    required this.planId,
    required this.startDate,
    required this.endDate,
    required this.servicemanId,
    required this.totalCampaignDiscountAmount,
    required this.totalCouponDiscountAmount,
    required this.couponCode,
    required this.isChecked,
    required this.additionalCharge,
    required this.additionalTaxAmount,
    required this.additionalDiscountAmount,
    required this.additionalCampaignDiscountAmount,
    required this.removedCouponAmount,
    required this.evidencePhotos,
    required this.bookingOtp,
    required this.isGuest,
    required this.isVerified,
    required this.extraFee,
    required this.totalReferralDiscountAmount,
    required this.isRepeated,
    required this.assignedBy,
    required this.serviceLocation,
    required this.serviceAddressLocation,
    required this.serviceData,
    required this.repeats,
    required this.evidencePhotosFullPath,
    required this.subCategory,
    required this.vehicle,
    required this.bookingOccurrences,
    required this.detail,
  });

  factory BookingData.fromJson(Map<String, dynamic> json) {
    return BookingData(
      id: json['id'],
      readableId: json['readable_id'],
      customerId: json['customer_id'],
      providerId: json['provider_id'],
      zoneId: json['zone_id'],
      bookingStatus: json['booking_status'],
      isPaid: json['is_paid'],
      paymentMethod: json['payment_method'],
      transactionId: json['transaction_id'],
      totalBookingAmount: json['total_booking_amount'].toDouble(),
      totalTaxAmount: json['total_tax_amount'].toDouble(),
      totalDiscountAmount: json['total_discount_amount'].toDouble(),
      serviceSchedule: json['service_schedule'],
      slot: json['slot'],
      serviceAddressId: json['service_address_id'],
      serviceVehicleDetailsId: json['service_vehicle_details_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      categoryId: json['category_id'],
      subCategoryId: json['sub_category_id'],
      planId: json['plan_id'],
      startDate: json['start_date'],
      endDate: json['end_date'],
      servicemanId: json['serviceman_id'],
      totalCampaignDiscountAmount:
      json['total_campaign_discount_amount'].toDouble(),
      totalCouponDiscountAmount: json['total_coupon_discount_amount'].toDouble(),
      couponCode: json['coupon_code'],
      isChecked: json['is_checked'],
      additionalCharge: json['additional_charge'].toDouble(),
      additionalTaxAmount: json['additional_tax_amount'].toDouble(),
      additionalDiscountAmount: json['additional_discount_amount'].toDouble(),
      additionalCampaignDiscountAmount:
      json['additional_campaign_discount_amount'].toDouble(),
      removedCouponAmount: json['removed_coupon_amount'],
      evidencePhotos: json['evidence_photos'],
      bookingOtp: json['booking_otp'],
      isGuest: json['is_guest'],
      isVerified: json['is_verified'],
      extraFee: json['extra_fee'].toDouble(),
      totalReferralDiscountAmount:
      json['total_referral_discount_amount'].toDouble(),
      isRepeated: json['is_repeated'],
      assignedBy: json['assigned_by'],
      serviceLocation: json['service_location'],
      serviceAddressLocation: json['service_address_location'],
      serviceData: json['service_data'],
      repeats: json['repeats'] ?? [],
      evidencePhotosFullPath: json['evidence_photos_full_path'] ?? [],
      subCategory: BookingSubCategory.fromJson(json['sub_category']),
      vehicle: BookingVehicle.fromJson(json['vehicle']),
      bookingOccurrences: (json['booking_occurrences'] as List)
          .map((e) => BookingOccurrence.fromJson(e))
          .toList(),
      detail: (json['detail'] as List)
          .map((e) => BookingDetail.fromJson(e))
          .toList(),
    );
  }
}

class BookingSubCategory {
  final String id;
  final String name;
  final dynamic imageFullPath;
  final List<SubCategoryTranslation> translations;

  BookingSubCategory({
    required this.id,
    required this.name,
    required this.imageFullPath,
    required this.translations,
  });

  factory BookingSubCategory.fromJson(Map<String, dynamic> json) {
    return BookingSubCategory(
      id: json['id'],
      name: json['name'],
      imageFullPath: json['image_full_path'],
      translations: (json['translations'] as List)
          .map((e) => SubCategoryTranslation.fromJson(e))
          .toList(),
    );
  }
}

class SubCategoryTranslation {
  final int id;
  final String translationableType;
  final String translationableId;
  final String locale;
  final String key;
  final String value;

  SubCategoryTranslation({
    required this.id,
    required this.translationableType,
    required this.translationableId,
    required this.locale,
    required this.key,
    required this.value,
  });

  factory SubCategoryTranslation.fromJson(Map<String, dynamic> json) {
    return SubCategoryTranslation(
      id: json['id'],
      translationableType: json['translationable_type'],
      translationableId: json['translationable_id'],
      locale: json['locale'],
      key: json['key'],
      value: json['value'],
    );
  }
}

class BookingVehicle {
  final int id;
  final String userId;
  final String brand;
  final String type;
  final String model;
  final String color;
  final String vehicleNo;
  final String contactNo;
  final dynamic additionalDetails;
  final String createdAt;
  final String updatedAt;

  BookingVehicle({
    required this.id,
    required this.userId,
    required this.brand,
    required this.type,
    required this.model,
    required this.color,
    required this.vehicleNo,
    required this.contactNo,
    required this.additionalDetails,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BookingVehicle.fromJson(Map<String, dynamic> json) {
    return BookingVehicle(
      id: json['id'],
      userId: json['user_id'],
      brand: json['brand'],
      type: json['type'],
      model: json['model'],
      color: json['color'],
      vehicleNo: json['vehicle_no'],
      contactNo: json['contact_no'],
      additionalDetails: json['additional_details'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}

class BookingOccurrence {
  final int id;
  final String bookingId;
  final String date;
  final String status;
  final String note;
  final List<String> images;
  final String color;
  final String label;
  final String createdAt;
  final String updatedAt;

  BookingOccurrence({
    required this.id,
    required this.bookingId,
    required this.date,
    required this.status,
    required this.note,
    required this.images,
    required this.color,
    required this.label,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BookingOccurrence.fromJson(Map<String, dynamic> json) {
    return BookingOccurrence(
      id: json['id'],
      bookingId: json['booking_id'],
      date: json['date'],
      status: json['status'],
      note: json['note'],
      images: List<String>.from(json['images']),
      color: json['color'],
      label: json['label'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}

class BookingDetail {
  final int id;
  final String bookingId;
  final String serviceId;
  final String serviceName;
  final String variantKey;
  final double serviceCost;
  final int quantity;
  final double discountAmount;
  final double taxAmount;
  final double totalCost;
  final String createdAt;
  final String updatedAt;
  final double campaignDiscountAmount;
  final double overallCouponDiscountAmount;

  BookingDetail({
    required this.id,
    required this.bookingId,
    required this.serviceId,
    required this.serviceName,
    required this.variantKey,
    required this.serviceCost,
    required this.quantity,
    required this.discountAmount,
    required this.taxAmount,
    required this.totalCost,
    required this.createdAt,
    required this.updatedAt,
    required this.campaignDiscountAmount,
    required this.overallCouponDiscountAmount,
  });

  factory BookingDetail.fromJson(Map<String, dynamic> json) {
    return BookingDetail(
      id: json['id'],
      bookingId: json['booking_id'],
      serviceId: json['service_id'],
      serviceName: json['service_name'],
      variantKey: json['variant_key'],
      serviceCost: json['service_cost'].toDouble(),
      quantity: json['quantity'],
      discountAmount: json['discount_amount'].toDouble(),
      taxAmount: json['tax_amount'].toDouble(),
      totalCost: json['total_cost'].toDouble(),
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      campaignDiscountAmount: json['campaign_discount_amount'].toDouble(),
      overallCouponDiscountAmount:
      json['overall_coupon_discount_amount'].toDouble(),
    );
  }
}