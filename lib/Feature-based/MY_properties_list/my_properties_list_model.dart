class MyPropertyList {
  bool status;
  MyPropertyListData? data;

  MyPropertyList({required this.status, this.data});

  MyPropertyList.fromJson(Map<String, dynamic> json)
      : status = json['status'] as bool,
        data = json['data'] != null ? MyPropertyListData.fromJson(json['data'] as Map<String, dynamic>) : null;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class MyPropertyListData {
  List<Properties> properties;
  List<PropertiesCategories> propertiesCategories;
  List<States> states;
  List<Districts> districts;
  List<Mandals> mandals;
  List<Villages> villages;
  List<UserDetails> userDetails;

  MyPropertyListData({
    required this.properties,
    required this.propertiesCategories,
    required this.states,
    required this.districts,
    required this.mandals,
    required this.villages,
    required this.userDetails,
  });

  MyPropertyListData.fromJson(Map<String, dynamic> json)
      : properties = json['properties'] != null
      ? (json['properties'] as List<dynamic>).map<Properties>((v) => Properties.fromJson(v as Map<String, dynamic>)).toList()
      : [],
        propertiesCategories = json['properties_categories'] != null
            ? (json['properties_categories'] as List<dynamic>).map<PropertiesCategories>((v) => PropertiesCategories.fromJson(v as Map<String, dynamic>)).toList()
            : [],
        states = json['states'] != null
            ? (json['states'] as List<dynamic>).map<States>((v) => States.fromJson(v as Map<String, dynamic>)).toList()
            : [],
        districts = json['districts'] != null
            ? (json['districts'] as List<dynamic>).map<Districts>((v) => Districts.fromJson(v as Map<String, dynamic>)).toList()
            : [],
        mandals = json['mandals'] != null
            ? (json['mandals'] as List<dynamic>).map<Mandals>((v) => Mandals.fromJson(v as Map<String, dynamic>)).toList()
            : [],
        villages = json['villages'] != null
            ? (json['villages'] as List<dynamic>).map<Villages>((v) => Villages.fromJson(v as Map<String, dynamic>)).toList()
            : [],
        userDetails = json['user_details'] != null
            ? (json['user_details'] as List<dynamic>).map<UserDetails>((v) => UserDetails.fromJson(v as Map<String, dynamic>)).toList()
            : [];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['properties'] = properties.map((v) => v.toJson()).toList();
    data['properties_categories'] = propertiesCategories.map((v) => v.toJson()).toList();
    data['states'] = states.map((v) => v.toJson()).toList();
    data['districts'] = districts.map((v) => v.toJson()).toList();
    data['mandals'] = mandals.map((v) => v.toJson()).toList();
    data['villages'] = villages.map((v) => v.toJson()).toList();
    data['user_details'] = userDetails.map((v) => v.toJson()).toList();
    return data;
  }
}

class Properties {
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
  String? planStartDate;
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

  Properties({
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

  Properties.fromJson(Map<String, dynamic> json)
      : id = json['id']?.toString(),
        addedDateTime = json['added_date_time']?.toString(),
        transactionDate = json['transaction_date']?.toString(),
        financialYearId = json['financial_year_id']?.toString(),
        branchId = json['branch_id']?.toString(),
        userId = json['user_id']?.toString(),
        refPrefix = json['ref_prefix']?.toString(),
        referenceNumber = json['reference_number']?.toString(),
        finalRefNumber = json['final_ref_number']?.toString(),
        propertyCatId = json['property_cat_id']?.toString(),
        propertyName = json['property_name']?.toString(),
        title = json['title']?.toString(),
        propertyFor = json['property_for']?.toString(),
        description = json['description']?.toString(),
        stateId = json['state_id']?.toString(),
        districtId = json['district_id']?.toString(),
        mandalId = json['mandal_id']?.toString(),
        villageId = json['village_id']?.toString(),
        streetName = json['street_name']?.toString(),
        pinCode = json['pin_code']?.toString(),
        facingDirection = json['facing_direction']?.toString(),
        price = json['price']?.toString(),
        totalArea = json['total_area']?.toString(),
        propertyImage = json['property_image']?.toString(),
        personName = json['person_name']?.toString(),
        personNumber = json['person_number']?.toString(),
        propertyDesc = json['property_desc']?.toString(),
        bookingAmount = json['booking_amount']?.toString(),
        maintenanceCharges = json['maintenance_charges']?.toString(),
        reraNumber = json['rera_number']?.toString(),
        longitude = json['longitude']?.toString(),
        latitude = json['latitude']?.toString(),
        apartmentArea = json['apartment_area']?.toString(),
        builtupArea = json['builtup_area']?.toString(),
        bedrooms = json['bedrooms']?.toString(),
        bathrooms = json['bathrooms']?.toString(),
        parking = json['parking']?.toString(),
        plotArea = json['plot_area']?.toString(),
        plotLength = json['plot_length']?.toString(),
        plotWidth = json['plot_width']?.toString(),
        villaBuiltupArea = json['villa_builtup_area']?.toString(),
        villaFloors = json['villa_floors']?.toString(),
        villaGarden = json['villa_garden']?.toString(),
        commercialArea = json['commercial_area']?.toString(),
        floorLevel = json['floor_level']?.toString(),
        suitableFor = json['suitable_for']?.toString(),
        floorPlanTitle = json['floor_plan_title']?.toString(),
        floorPlanArea = json['floor_plan_area']?.toString(),
        floorPlanImage = json['floor_plan_image']?.toString(),
        floorPlanDescription = json['floor_plan_description']?.toString(),
        propertyStatusId = json['property_status_id']?.toString(),
        active = json['active']?.toString(),
        approved = json['approved']?.toString(),
        postedDate = json['posted_date']?.toString(),
        planStartDate = json['plan_start_date']?.toString(), ////

        planExpiryDate = json['plan_expiry_date']?.toString(),
        propertyPlan = json['property_plan']?.toString(),
        totalPlanPrice = json['total_plan_price']?.toString(),
        addedBy = json['added_by']?.toString(),
        addedByRole = json['added_by_role']?.toString(),
        lastUpdatedBy = json['last_updated_by']?.toString(),
        lastUpdatedByRole = json['last_updated_by_role']?.toString(),
        lastUpdatedDateTime = json['last_updated_date_time']?.toString(),
        insertedIp = json['inserted_ip']?.toString(),
        updatedIp = json['updated_ip']?.toString();

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
}

class PropertiesCategories {
  String? id;
  String? addedDateTime;
  String? branchId;
  String? financialYearId;
  String? propertyCategoryTitle;
  String? propertyCategoryIcon;
  String? addedBy;
  String? addedByRole;
  String? insertedIp;
  String? lastUpdatedDateTime;
  String? lastUpdatedBy;
  String? lastUpdatedByRole;
  String? updatedIp;

  PropertiesCategories({
    this.id,
    this.addedDateTime,
    this.branchId,
    this.financialYearId,
    this.propertyCategoryTitle,
    this.propertyCategoryIcon,
    this.addedBy,
    this.addedByRole,
    this.insertedIp,
    this.lastUpdatedDateTime,
    this.lastUpdatedBy,
    this.lastUpdatedByRole,
    this.updatedIp,
  });

  PropertiesCategories.fromJson(Map<String, dynamic> json)
      : id = json['id']?.toString(),
        addedDateTime = json['added_date_time']?.toString(),
        branchId = json['branch_id']?.toString(),
        financialYearId = json['financial_year_id']?.toString(),
        propertyCategoryTitle = json['property_category_title']?.toString(),
        propertyCategoryIcon = json['property_category_icon']?.toString(),
        addedBy = json['added_by']?.toString(),
        addedByRole = json['added_by_role']?.toString(),
        insertedIp = json['inserted_ip']?.toString(),
        lastUpdatedDateTime = json['last_updated_date_time']?.toString(),
        lastUpdatedBy = json['last_updated_by']?.toString(),
        lastUpdatedByRole = json['last_updated_by_role']?.toString(),
        updatedIp = json['updated_ip']?.toString();

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'added_date_time': addedDateTime,
      'branch_id': branchId,
      'financial_year_id': financialYearId,
      'property_category_title': propertyCategoryTitle,
      'property_category_icon': propertyCategoryIcon,
      'added_by': addedBy,
      'added_by_role': addedByRole,
      'inserted_ip': insertedIp,
      'last_updated_date_time': lastUpdatedDateTime,
      'last_updated_by': lastUpdatedBy,
      'last_updated_by_role': lastUpdatedByRole,
      'updated_ip': updatedIp,
    };
  }
}

class States {
  String? id;
  String? addedDateTime;
  String? transactionDate;
  String? financialYearId;
  String? branchId;
  String? stateName;
  String? activeStatus;
  String? addedBy;
  String? addedByRole;
  String? insertedIp;
  String? lastUpdatedDateTime;
  String? lastUpdatedBy;
  String? lastUpdatedByRole;
  String? updatedIp;

  States({
    this.id,
    this.addedDateTime,
    this.transactionDate,
    this.financialYearId,
    this.branchId,
    this.stateName,
    this.activeStatus,
    this.addedBy,
    this.addedByRole,
    this.insertedIp,
    this.lastUpdatedDateTime,
    this.lastUpdatedBy,
    this.lastUpdatedByRole,
    this.updatedIp,
  });

  States.fromJson(Map<String, dynamic> json)
      : id = json['id']?.toString(),
        addedDateTime = json['added_date_time']?.toString(),
        transactionDate = json['transaction_date']?.toString(),
        financialYearId = json['financial_year_id']?.toString(),
        branchId = json['branch_id']?.toString(),
        stateName = json['state_name']?.toString(),
        activeStatus = json['active_status']?.toString(),
        addedBy = json['added_by']?.toString(),
        addedByRole = json['added_by_role']?.toString(),
        insertedIp = json['inserted_ip']?.toString(),
        lastUpdatedDateTime = json['last_updated_date_time']?.toString(),
        lastUpdatedBy = json['last_updated_by']?.toString(),
        lastUpdatedByRole = json['last_updated_by_role']?.toString(),
        updatedIp = json['updated_ip']?.toString();

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'added_date_time': addedDateTime,
      'transaction_date': transactionDate,
      'financial_year_id': financialYearId,
      'branch_id': branchId,
      'state_name': stateName,
      'active_status': activeStatus,
      'added_by': addedBy,
      'added_by_role': addedByRole,
      'inserted_ip': insertedIp,
      'last_updated_date_time': lastUpdatedDateTime,
      'last_updated_by': lastUpdatedBy,
      'last_updated_by_role': lastUpdatedByRole,
      'updated_ip': updatedIp,
    };
  }
}

class Districts {
  String? id;
  String? addedDateTime;
  String? transactionDate;
  String? financialYearId;
  String? branchId;
  String? stateId;
  String? districtName;
  String? activeStatus;
  String? addedBy;
  String? addedByRole;
  String? lastUpdatedBy;
  String? lastUpdatedByRole;
  String? lastUpdatedDateTime;
  String? insertedIp;
  String? updatedIp;

  Districts({
    this.id,
    this.addedDateTime,
    this.transactionDate,
    this.financialYearId,
    this.branchId,
    this.stateId,
    this.districtName,
    this.activeStatus,
    this.addedBy,
    this.addedByRole,
    this.lastUpdatedBy,
    this.lastUpdatedByRole,
    this.lastUpdatedDateTime,
    this.insertedIp,
    this.updatedIp,
  });

  Districts.fromJson(Map<String, dynamic> json)
      : id = json['id']?.toString(),
        addedDateTime = json['added_date_time']?.toString(),
        transactionDate = json['transaction_date']?.toString(),
        financialYearId = json['financial_year_id']?.toString(),
        branchId = json['branch_id']?.toString(),
        stateId = json['state_id']?.toString(),
        districtName = json['district_name']?.toString(),
        activeStatus = json['active_status']?.toString(),
        addedBy = json['added_by']?.toString(),
        addedByRole = json['added_by_role']?.toString(),
        lastUpdatedBy = json['last_updated_by']?.toString(),
        lastUpdatedByRole = json['last_updated_by_role']?.toString(),
        lastUpdatedDateTime = json['last_updated_date_time']?.toString(),
        insertedIp = json['inserted_ip']?.toString(),
        updatedIp = json['updated_ip']?.toString();

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'added_date_time': addedDateTime,
      'transaction_date': transactionDate,
      'financial_year_id': financialYearId,
      'branch_id': branchId,
      'state_id': stateId,
      'district_name': districtName,
      'active_status': activeStatus,
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

class Mandals {
  String? id;
  String? addedDateTime;
  String? transactionDate;
  String? financialYearId;
  String? branchId;
  String? stateId;
  String? districtId;
  String? mandalName;
  String? activeStatus;
  String? addedBy;
  String? addedByRole;
  String? lastUpdatedBy;
  String? lastUpdatedByRole;
  String? lastUpdatedDateTime;
  String? insertedIp;
  String? updatedIp;

  Mandals({
    this.id,
    this.addedDateTime,
    this.transactionDate,
    this.financialYearId,
    this.branchId,
    this.stateId,
    this.districtId,
    this.mandalName,
    this.activeStatus,
    this.addedBy,
    this.addedByRole,
    this.lastUpdatedBy,
    this.lastUpdatedByRole,
    this.lastUpdatedDateTime,
    this.insertedIp,
    this.updatedIp,
  });

  Mandals.fromJson(Map<String, dynamic> json)
      : id = json['id']?.toString(),
        addedDateTime = json['added_date_time']?.toString(),
        transactionDate = json['transaction_date']?.toString(),
        financialYearId = json['financial_year_id']?.toString(),
        branchId = json['branch_id']?.toString(),
        stateId = json['state_id']?.toString(),
        districtId = json['district_id']?.toString(),
        mandalName = json['mandal_name']?.toString(),
        activeStatus = json['active_status']?.toString(),
        addedBy = json['added_by']?.toString(),
        addedByRole = json['added_by_role']?.toString(),
        lastUpdatedBy = json['last_updated_by']?.toString(),
        lastUpdatedByRole = json['last_updated_by_role']?.toString(),
        lastUpdatedDateTime = json['last_updated_date_time']?.toString(),
        insertedIp = json['inserted_ip']?.toString(),
        updatedIp = json['updated_ip']?.toString();

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'added_date_time': addedDateTime,
      'transaction_date': transactionDate,
      'financial_year_id': financialYearId,
      'branch_id': branchId,
      'state_id': stateId,
      'district_id': districtId,
      'mandal_name': mandalName,
      'active_status': activeStatus,
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

class Villages {
  String? id;
  String? addedDateTime;
  String? transactionDate;
  String? financialYearId;
  String? branchId;
  String? stateId;
  String? districtId;
  String? mandalId;
  String? villageName;
  String? pinCode;
  String? activeStatus;
  String? addedBy;
  String? addedByRole;
  String? lastUpdatedBy;
  String? lastUpdatedByRole;
  String? lastUpdatedDateTime;
  String? insertedIp;
  String? updatedIp;

  Villages({
    this.id,
    this.addedDateTime,
    this.transactionDate,
    this.financialYearId,
    this.branchId,
    this.stateId,
    this.districtId,
    this.mandalId,
    this.villageName,
    this.pinCode,
    this.activeStatus,
    this.addedBy,
    this.addedByRole,
    this.lastUpdatedBy,
    this.lastUpdatedByRole,
    this.lastUpdatedDateTime,
    this.insertedIp,
    this.updatedIp,
  });

  Villages.fromJson(Map<String, dynamic> json)
      : id = json['id']?.toString(),
        addedDateTime = json['added_date_time']?.toString(),
        transactionDate = json['transaction_date']?.toString(),
        financialYearId = json['financial_year_id']?.toString(),
        branchId = json['branch_id']?.toString(),
        stateId = json['state_id']?.toString(),
        districtId = json['district_id']?.toString(),
        mandalId = json['mandal_id']?.toString(),
        villageName = json['village_name']?.toString(),
        pinCode = json['pin_code']?.toString(),
        activeStatus = json['active_status']?.toString(),
        addedBy = json['added_by']?.toString(),
        addedByRole = json['added_by_role']?.toString(),
        lastUpdatedBy = json['last_updated_by']?.toString(),
        lastUpdatedByRole = json['last_updated_by_role']?.toString(),
        lastUpdatedDateTime = json['last_updated_date_time']?.toString(),
        insertedIp = json['inserted_ip']?.toString(),
        updatedIp = json['updated_ip']?.toString();

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'added_date_time': addedDateTime,
      'transaction_date': transactionDate,
      'financial_year_id': financialYearId,
      'branch_id': branchId,
      'state_id': stateId,
      'district_id': districtId,
      'mandal_id': mandalId,
      'village_name': villageName,
      'pin_code': pinCode,
      'active_status': activeStatus,
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

class UserDetails {
  String? id;
  String? referenceNumber;
  String? personName;
  String? email;
  String? username;
  String? oldImage;
  String? profileImage;

  UserDetails({
    this.id,
    this.referenceNumber,
    this.personName,
    this.email,
    this.username,
    this.oldImage,
    this.profileImage,
  });

  UserDetails.fromJson(Map<String, dynamic> json)
      : id = json['id']?.toString(),
        referenceNumber = json['reference_number']?.toString(),
        personName = json['person_name']?.toString(),
        email = json['email']?.toString(),
        username = json['username']?.toString(),
        oldImage = json['old_image']?.toString(),
        profileImage = json['profile_image']?.toString();

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'reference_number': referenceNumber,
      'person_name': personName,
      'email': email,
      'username': username,
      'old_image': oldImage,
      'profile_image': profileImage,
    };
  }
}