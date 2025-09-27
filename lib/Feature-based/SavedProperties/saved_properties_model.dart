class FavoritePropertiesResponse {
  bool? status;
  FavoritePropertiesDataWrapper? data;

  FavoritePropertiesResponse({this.status, this.data});

  factory FavoritePropertiesResponse.fromJson(Map<String, dynamic> json) {
    return FavoritePropertiesResponse(
      status: json['status'],
      data: json['data'] != null
          ? FavoritePropertiesDataWrapper.fromJson(json['data'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'data': data?.toJson(),
    };
  }
}

class FavoritePropertiesDataWrapper {
  List<FavoritePropertyData>? favoritePropertiesData;
  List<FavoriteProperty>? favoriteProperties;

  FavoritePropertiesDataWrapper({
    this.favoritePropertiesData,
    this.favoriteProperties,
  });

  factory FavoritePropertiesDataWrapper.fromJson(Map<String, dynamic> json) {
    return FavoritePropertiesDataWrapper(
      favoritePropertiesData: (json['favorite_properties_data'] as List<dynamic>?)
          ?.map((e) => FavoritePropertyData.fromJson(e))
          .toList(),
      favoriteProperties: (json['favorite_properties'] as List<dynamic>?)
          ?.map((e) => FavoriteProperty.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'favorite_properties_data':
      favoritePropertiesData?.map((e) => e.toJson()).toList(),
      'favorite_properties':
      favoriteProperties?.map((e) => e.toJson()).toList(),
    };
  }
}

class FavoritePropertyData {
  String? id;
  String? userId;
  String? propertyId;
  String? status;

  FavoritePropertyData({
    this.id,
    this.userId,
    this.propertyId,
    this.status,
  });

  factory FavoritePropertyData.fromJson(Map<String, dynamic> json) {
    return FavoritePropertyData(
      id: json['id'],
      userId: json['user_id'],
      propertyId: json['property_id'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'property_id': propertyId,
      'status': status,
    };
  }
}

class FavoriteProperty {
  String? id;
  String? addedDateTime;
  String? transactionDate;
  String? financialYearId;
  String? branchId;
  String? userId;
  String? refPrefix;
  String? referenceNumber;
  String? finalRefNumber;
  String? propertyCatId;
  String? propertyName;
  String? title;
  String? propertyFor;
  String? description;
  String? stateId;
  String? districtId;
  String? mandalId;
  String? villageId;
  String? streetName;
  String? pinCode;
  String? facingDirection;
  String? price;
  String? totalArea;
  String? propertyImage;
  String? personName;
  String? personNumber;
  String? propertyDesc;
  String? bookingAmount;
  String? maintenanceCharges;
  String? reraNumber;
  String? longitude;
  String? latitude;
  String? apartmentArea;
  String? builtupArea;
  String? bedrooms;
  String? bathrooms;
  String? parking;
  String? plotArea;
  String? plotLength;
  String? plotWidth;
  String? villaBuiltupArea;
  String? villaFloors;
  String? villaGarden;
  String? commercialArea;
  String? floorLevel;
  String? suitableFor;
  String? floorPlanTitle;
  String? floorPlanArea;
  String? floorPlanImage;
  String? floorPlanDescription;
  String? propertyStatusId;
  String? active;
  String? approved;
  String? postedDate;
  String? planExpiryDate;
  String? propertyPlan;
  String? totalPlanPrice;
  String? addedBy;
  String? addedByRole;
  String? lastUpdatedBy;
  String? lastUpdatedByRole;
  String? lastUpdatedDateTime;
  String? insertedIp;
  String? updatedIp;

  FavoriteProperty({
    this.id,
    this.addedDateTime,
    this.transactionDate,
    this.financialYearId,
    this.branchId,
    this.userId,
    this.refPrefix,
    this.referenceNumber,
    this.finalRefNumber,
    this.propertyCatId,
    this.propertyName,
    this.title,
    this.propertyFor,
    this.description,
    this.stateId,
    this.districtId,
    this.mandalId,
    this.villageId,
    this.streetName,
    this.pinCode,
    this.facingDirection,
    this.price,
    this.totalArea,
    this.propertyImage,
    this.personName,
    this.personNumber,
    this.propertyDesc,
    this.bookingAmount,
    this.maintenanceCharges,
    this.reraNumber,
    this.longitude,
    this.latitude,
    this.apartmentArea,
    this.builtupArea,
    this.bedrooms,
    this.bathrooms,
    this.parking,
    this.plotArea,
    this.plotLength,
    this.plotWidth,
    this.villaBuiltupArea,
    this.villaFloors,
    this.villaGarden,
    this.commercialArea,
    this.floorLevel,
    this.suitableFor,
    this.floorPlanTitle,
    this.floorPlanArea,
    this.floorPlanImage,
    this.floorPlanDescription,
    this.propertyStatusId,
    this.active,
    this.approved,
    this.postedDate,
    this.planExpiryDate,
    this.propertyPlan,
    this.totalPlanPrice,
    this.addedBy,
    this.addedByRole,
    this.lastUpdatedBy,
    this.lastUpdatedByRole,
    this.lastUpdatedDateTime,
    this.insertedIp,
    this.updatedIp,
  });

  factory FavoriteProperty.fromJson(Map<String, dynamic> json) {
    return FavoriteProperty(
      id: json['id'],
      addedDateTime: json['added_date_time'],
      transactionDate: json['transaction_date'],
      financialYearId: json['financial_year_id'],
      branchId: json['branch_id'],
      userId: json['user_id'],
      refPrefix: json['ref_prefix'],
      referenceNumber: json['reference_number'],
      finalRefNumber: json['final_ref_number'],
      propertyCatId: json['property_cat_id'],
      propertyName: json['property_name'],
      title: json['title'],
      propertyFor: json['property_for'],
      description: json['description'],
      stateId: json['state_id'],
      districtId: json['district_id'],
      mandalId: json['mandal_id'],
      villageId: json['village_id'],
      streetName: json['street_name'],
      pinCode: json['pin_code'],
      facingDirection: json['facing_direction'],
      price: json['price'],
      totalArea: json['total_area'],
      propertyImage: json['property_image'],
      personName: json['person_name'],
      personNumber: json['person_number'],
      propertyDesc: json['property_desc'],
      bookingAmount: json['booking_amount'],
      maintenanceCharges: json['maintenance_charges'],
      reraNumber: json['rera_number'],
      longitude: json['longitude'],
      latitude: json['latitude'],
      apartmentArea: json['apartment_area'],
      builtupArea: json['builtup_area'],
      bedrooms: json['bedrooms'],
      bathrooms: json['bathrooms'],
      parking: json['parking'],
      plotArea: json['plot_area'],
      plotLength: json['plot_length'],
      plotWidth: json['plot_width'],
      villaBuiltupArea: json['villa_builtup_area'],
      villaFloors: json['villa_floors'],
      villaGarden: json['villa_garden'],
      commercialArea: json['commercial_area'],
      floorLevel: json['floor_level'],
      suitableFor: json['suitable_for'],
      floorPlanTitle: json['floor_plan_title'],
      floorPlanArea: json['floor_plan_area'],
      floorPlanImage: json['floor_plan_image'],
      floorPlanDescription: json['floor_plan_description'],
      propertyStatusId: json['property_status_id'],
      active: json['active'],
      approved: json['approved'],
      postedDate: json['posted_date'],
      planExpiryDate: json['plan_expiry_date'],
      propertyPlan: json['property_plan'],
      totalPlanPrice: json['total_plan_price'],
      addedBy: json['added_by'],
      addedByRole: json['added_by_role'],
      lastUpdatedBy: json['last_updated_by'],
      lastUpdatedByRole: json['last_updated_by_role'],
      lastUpdatedDateTime: json['last_updated_date_time'],
      insertedIp: json['inserted_ip'],
      updatedIp: json['updated_ip'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'added_date_time': addedDateTime,
      'transaction_date': transactionDate,
      'financial_year_id': financialYearId,
      'branch_id': branchId,
      'user_id': userId,
      'ref_prefix': refPrefix,
      'reference_number': referenceNumber,
      'final_ref_number': finalRefNumber,
      'property_cat_id': propertyCatId,
      'property_name': propertyName,
      'title': title,
      'property_for': propertyFor,
      'description': description,
      'state_id': stateId,
      'district_id': districtId,
      'mandal_id': mandalId,
      'village_id': villageId,
      'street_name': streetName,
      'pin_code': pinCode,
      'facing_direction': facingDirection,
      'price': price,
      'total_area': totalArea,
      'property_image': propertyImage,
      'person_name': personName,
      'person_number': personNumber,
      'property_desc': propertyDesc,
      'booking_amount': bookingAmount,
      'maintenance_charges': maintenanceCharges,
      'rera_number': reraNumber,
      'longitude': longitude,
      'latitude': latitude,
      'apartment_area': apartmentArea,
      'builtup_area': builtupArea,
      'bedrooms': bedrooms,
      'bathrooms': bathrooms,
      'parking': parking,
      'plot_area': plotArea,
      'plot_length': plotLength,
      'plot_width': plotWidth,
      'villa_builtup_area': villaBuiltupArea,
      'villa_floors': villaFloors,
      'villa_garden': villaGarden,
      'commercial_area': commercialArea,
      'floor_level': floorLevel,
      'suitable_for': suitableFor,
      'floor_plan_title': floorPlanTitle,
      'floor_plan_area': floorPlanArea,
      'floor_plan_image': floorPlanImage,
      'floor_plan_description': floorPlanDescription,
      'property_status_id': propertyStatusId,
      'active': active,
      'approved': approved,
      'posted_date': postedDate,
      'plan_expiry_date': planExpiryDate,
      'property_plan': propertyPlan,
      'total_plan_price': totalPlanPrice,
      'added_by': addedBy,
      'added_by_role': addedByRole,
      'last_updated_by': lastUpdatedBy,
      'last_updated_by_role': lastUpdatedByRole,
      'last_updated_date_time': lastUpdatedDateTime,
      'inserted_ip': insertedIp,
      'updated_ip': updatedIp,
    };
  }
}
