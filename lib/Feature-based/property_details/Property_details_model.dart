
class PropertyDetailsModel {
  final bool? status;
  final List<PropertyDetails>? propertyDetails;
  final List<PropertiesCategory>? propertiesCategories;
  final List<StateModel>? states;
  final List<District>? districts;
  final List<Mandal>? mandals;
  final List<Village>? villages;

  PropertyDetailsModel({
    this.status,
    this.propertyDetails,
    this.propertiesCategories,
    this.states,
    this.districts,
    this.mandals,
    this.villages,
  });

  factory PropertyDetailsModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>?;

    return PropertyDetailsModel(
      status: json['status'] as bool?,
      propertyDetails: (data?['property_details'] as List<dynamic>?)
          ?.map((e) => PropertyDetails.fromJson(e as Map<String, dynamic>))
          .toList(),
      propertiesCategories: (data?['properties_categories'] as List<dynamic>?)
          ?.map((e) => PropertiesCategory.fromJson(e as Map<String, dynamic>))
          .toList(),
      states: (data?['states'] as List<dynamic>?)
          ?.map((e) => StateModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      districts: (data?['districts'] as List<dynamic>?)
          ?.map((e) => District.fromJson(e as Map<String, dynamic>))
          .toList(),
      mandals: (data?['mandals'] as List<dynamic>?)
          ?.map((e) => Mandal.fromJson(e as Map<String, dynamic>))
          .toList(),
      villages: (data?['villages'] as List<dynamic>?)
          ?.map((e) => Village.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'status': status,
    'property_details': propertyDetails?.map((e) => e.toJson()).toList(),
    'properties_categories':
    propertiesCategories?.map((e) => e.toJson()).toList(),
    'states': states?.map((e) => e.toJson()).toList(),
    'districts': districts?.map((e) => e.toJson()).toList(),
    'mandals': mandals?.map((e) => e.toJson()).toList(),
    'villages': villages?.map((e) => e.toJson()).toList(),
  };
}

class PropertyDetails {
  final String? id;
  final String? addedDateTime;
  final String? transactionDate;
  final String? financialYearId;
  final String? branchId;
  final String? userId;
  final String? refPrefix;
  final String? referenceNumber;
  final String? finalRefNumber;
  final String? propertyCatId;
  final String? propertyName;
  final String? title;
  final String? propertyFor;
  final String? description;
  final String? stateId;
  final String? districtId;
  final String? mandalId;
  final String? villageId;
  final String? streetName;
  final String? pinCode;
  final String? facingDirection;
  final String? price;
  final String? totalArea;
  final String? propertyImage;
  final String? personName;
  final String? personNumber;
  final String? propertyDesc;
  final String? bookingAmount;
  final String? maintenanceCharges;
  final String? reraNumber;
  final String? longitude;
  final String? latitude;
  final String? apartmentArea;
  final String? builtupArea;
  final String? villaBuiltupArea;
  final String? bedrooms;
  final String? bathrooms;
  final String? parking;
  final String? plotArea;
  final String? plotLength;
  final String? plotWidth;
  final String? villaFloors;
  final String? villaGarden;
  final String? commercialArea;
  final String? floorLevel;
  final String? suitableFor;
  final String? floorPlanTitle;
  final String? floorPlanArea;
  final String? floorPlanImage;
  final String? floorPlanDescription;
  final String? propertyStatusId;
  final String? active;
  final String? approved;
  final String? postedDate;
  final String? planDaysId;
  final String? noOfPlanDays;
  final String? planStartDate;
  final String? planExpiryDate;
  final String? propertyPlan;
  final String? totalPlanPrice;
  final String? addedBy;
  final String? addedByRole;
  final String? lastUpdatedBy;
  final String? lastUpdatedByRole;
  final String? lastUpdatedDateTime;
  final String? insertedIp;
  final String? updatedIp;

  PropertyDetails({
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
    this.villaBuiltupArea,
    this.bedrooms,
    this.bathrooms,
    this.parking,
    this.plotArea,
    this.plotLength,
    this.plotWidth,
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
    this.planDaysId,
    this.noOfPlanDays,
    this.planStartDate,
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

  factory PropertyDetails.fromJson(Map<String, dynamic> json) => PropertyDetails(
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
    villaBuiltupArea: json['villa_builtup_area'],
    bedrooms: json['bedrooms'],
    bathrooms: json['bathrooms'],
    parking: json['parking'],
    plotArea: json['plot_area'],
    plotLength: json['plot_length'],
    plotWidth: json['plot_width'],
    villaFloors: json['villa_floors'],
    villaGarden: json['villa_garden'],
    commercialArea: json['commercial_area'],
    floorLevel: json['floor_level'],
    suitableFor: json['suitable_for'],
    floorPlanTitle: json['floor_plan_title'],
    floorPlanArea: json['floor_plan_area'],
    floorPlanImage: json['floor_plan_image'],
    floorPlanDescription: json['description'],
    propertyStatusId: json['property_status_id'],
    active: json['active'],
    approved: json['approved'],
    postedDate: json['posted_date'],
    planDaysId: json['plan_days_id'],
    noOfPlanDays: json['no_of_plan_days'],
    planStartDate: json['plan_start_date'],
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

  Map<String, dynamic> toJson() => {
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
    'villa_builtup_area': villaBuiltupArea,
    'bedrooms': bedrooms,
    'bathrooms': bathrooms,
    'parking': parking,
    'plot_area': plotArea,
    'plot_length': plotLength,
    'plot_width': plotWidth,
    'villa_floors': villaFloors,
    'villa_garden': villaGarden,
    'commercial_area': commercialArea,
    'floor_level': floorLevel,
    'suitable_for': suitableFor,
    'floor_plan_title': floorPlanTitle,
    'floor_plan_area': floorPlanArea,
    'floor_plan_image': floorPlanImage,
    'description': floorPlanDescription,
    'property_status_id': propertyStatusId,
    'active': active,
    'approved': approved,
    'posted_date': postedDate,
    'plan_days_id': planDaysId,
    'no_of_plan_days': noOfPlanDays,
    'plan_start_date': planStartDate,
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

class PropertiesCategory {
  final String? id;
  final String? title;
  final String? icon;

  PropertiesCategory({this.id, this.title, this.icon});

  factory PropertiesCategory.fromJson(Map<String, dynamic> json) =>
      PropertiesCategory(
        id: json['id'] as String?,
        title: json['property_category_title'] as String?,
        icon: json['property_category_icon'] as String?,
      );

  Map<String, dynamic> toJson() => {
    'id': id,
    'property_category_title': title,
    'property_category_icon': icon,
  };
}

class StateModel {
  final String? id;
  final String? name;

  StateModel({this.id, this.name});

  factory StateModel.fromJson(Map<String, dynamic> json) => StateModel(
    id: json['id'] as String?,
    name: json['state_name'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'state_name': name,
  };
}

class District {
  final String? id;
  final String? stateId;
  final String? name;

  District({this.id, this.stateId, this.name});

  factory District.fromJson(Map<String, dynamic> json) => District(
    id: json['id'] as String?,
    stateId: json['state_id'] as String?,
    name: json['district_name'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'state_id': stateId,
    'district_name': name,
  };
}

class Mandal {
  final String? id;
  final String? stateId;
  final String? districtId;
  final String? name;

  Mandal({this.id, this.stateId, this.districtId, this.name});

  factory Mandal.fromJson(Map<String, dynamic> json) => Mandal(
    id: json['id'] as String?,
    stateId: json['state_id'] as String?,
    districtId: json['district_id'] as String?,
    name: json['mandal_name'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'state_id': stateId,
    'district_id': districtId,
    'mandal_name': name,
  };
}

class Village {
  final String? id;
  final String? stateId;
  final String? districtId;
  final String? mandalId;
  final String? name;
  final String? pinCode;

  Village({
    this.id,
    this.stateId,
    this.districtId,
    this.mandalId,
    this.name,
    this.pinCode,
  });

  factory Village.fromJson(Map<String, dynamic> json) => Village(
    id: json['id'] as String?,
    stateId: json['state_id'] as String?,
    districtId: json['district_id'] as String?,
    mandalId: json['mandal_id'] as String?,
    name: json['village_name'] as String?,
    pinCode: json['pin_code'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'state_id': stateId,
    'district_id': districtId,
    'mandal_id': mandalId,
    'village_name': name,
    'pin_code': pinCode,
  };
}
