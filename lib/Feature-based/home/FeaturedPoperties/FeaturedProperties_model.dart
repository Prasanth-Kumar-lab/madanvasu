class PropertiesListModel {
  bool? status;
  PropertiesDataWrapper? data;

  PropertiesListModel({this.status, this.data});

  PropertiesListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? PropertiesDataWrapper.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonData = {};
    jsonData['status'] = status;
    if (data != null) {
      jsonData['data'] = data!.toJson();
    }
    return jsonData;
  }
}

////  Wrapper for 'data' object containing all lists

class PropertiesDataWrapper {
  List<PropertiesData>? properties;
  List<PropertyCategory>? propertiesCategories;
  List<StateModel>? states;
  List<District>? districts;
  List<Mandal>? mandals;
  List<Village>? villages;

  PropertiesDataWrapper({
    this.properties,
    this.propertiesCategories,
    this.states,
    this.districts,
    this.mandals,
    this.villages,
  });

  PropertiesDataWrapper.fromJson(Map<String, dynamic> json) {
    if (json['properties'] != null) {
      properties = <PropertiesData>[];
      json['properties'].forEach((v) {
        properties!.add(PropertiesData.fromJson(v));
      });
    }
    if (json['properties_categories'] != null) {
      propertiesCategories = <PropertyCategory>[];
      json['properties_categories'].forEach((v) {
        propertiesCategories!.add(PropertyCategory.fromJson(v));
      });
    }
    if (json['states'] != null) {
      states = <StateModel>[];
      json['states'].forEach((v) {
        states!.add(StateModel.fromJson(v));
      });
    }
    if (json['districts'] != null) {
      districts = <District>[];
      json['districts'].forEach((v) {
        districts!.add(District.fromJson(v));
      });
    }
    if (json['mandals'] != null) {
      mandals = <Mandal>[];
      json['mandals'].forEach((v) {
        mandals!.add(Mandal.fromJson(v));
      });
    }
    if (json['villages'] != null) {
      villages = <Village>[];
      json['villages'].forEach((v) {
        villages!.add(Village.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (properties != null) {
      data['properties'] = properties!.map((v) => v.toJson()).toList();
    }
    if (propertiesCategories != null) {
      data['properties_categories'] = propertiesCategories!.map((v) => v.toJson()).toList();
    }
    if (states != null) {
      data['states'] = states!.map((v) => v.toJson()).toList();
    }
    if (districts != null) {
      data['districts'] = districts!.map((v) => v.toJson()).toList();
    }
    if (mandals != null) {
      data['mandals'] = mandals!.map((v) => v.toJson()).toList();
    }
    if (villages != null) {
      data['villages'] = villages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PropertiesData {
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
  String? expiryDate;
  String? addedBy;
  String? addedByRole;
  String? lastUpdatedBy;
  String? lastUpdatedByRole;
  String? lastUpdatedDateTime;
  String? insertedIp;
  String? updatedIp;

  PropertiesData({
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
    this.expiryDate,
    this.addedBy,
    this.addedByRole,
    this.lastUpdatedBy,
    this.lastUpdatedByRole,
    this.lastUpdatedDateTime,
    this.insertedIp,
    this.updatedIp,
  });

  PropertiesData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    addedDateTime = json['added_date_time'];
    transactionDate = json['transaction_date'];
    financialYearId = json['financial_year_id'];
    branchId = json['branch_id'];
    userId = json['user_id'];
    refPrefix = json['ref_prefix'];
    referenceNumber = json['reference_number'];
    finalRefNumber = json['final_ref_number'];
    propertyCatId = json['property_cat_id'];
    propertyName = json['property_name'];
    title = json['title'];
    propertyFor = json['property_for'];
    description = json['description'];
    stateId = json['state_id'];
    districtId = json['district_id'];
    mandalId = json['mandal_id'];
    villageId = json['village_id'];
    streetName = json['street_name'];
    pinCode = json['pin_code'];
    facingDirection = json['facing_direction'];
    price = json['price'];
    totalArea = json['total_area'];
    propertyImage = json['property_image'];
    personName = json['person_name'];
    personNumber = json['person_number'];
    propertyDesc = json['property_desc'];
    bookingAmount = json['booking_amount'];
    maintenanceCharges = json['maintenance_charges'];
    reraNumber = json['rera_number'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    apartmentArea = json['apartment_area'];
    builtupArea = json['builtup_area'];
    bedrooms = json['bedrooms'];
    bathrooms = json['bathrooms'];
    parking = json['parking'];
    plotArea = json['plot_area'];
    plotLength = json['plot_length'];
    plotWidth = json['plot_width'];
    villaBuiltupArea = json['villa_builtup_area'];
    villaFloors = json['villa_floors'];
    villaGarden = json['villa_garden'];
    commercialArea = json['commercial_area'];
    floorLevel = json['floor_level'];
    suitableFor = json['suitable_for'];
    floorPlanTitle = json['floor_plan_title'];
    floorPlanArea = json['floor_plan_area'];
    floorPlanImage = json['floor_plan_image'];
    floorPlanDescription = json['floor_plan_description'];
    propertyStatusId = json['property_status_id'];
    active = json['active'];
    approved = json['approved'];
    postedDate = json['posted_date'];
    expiryDate = json['expiry_date'];
    addedBy = json['added_by'];
    addedByRole = json['added_by_role'];
    lastUpdatedBy = json['last_updated_by'];
    lastUpdatedByRole = json['last_updated_by_role'];
    lastUpdatedDateTime = json['last_updated_date_time'];
    insertedIp = json['inserted_ip'];
    updatedIp = json['updated_ip'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonData = {};
    jsonData['id'] = id;
    jsonData['added_date_time'] = addedDateTime;
    jsonData['transaction_date'] = transactionDate;
    jsonData['financial_year_id'] = financialYearId;
    jsonData['branch_id'] = branchId;
    jsonData['user_id'] = userId;
    jsonData['ref_prefix'] = refPrefix;
    jsonData['reference_number'] = referenceNumber;
    jsonData['final_ref_number'] = finalRefNumber;
    jsonData['property_cat_id'] = propertyCatId;
    jsonData['property_name'] = propertyName;
    jsonData['title'] = title;
    jsonData['property_for'] = propertyFor;
    jsonData['description'] = description;
    jsonData['state_id'] = stateId;
    jsonData['district_id'] = districtId;
    jsonData['mandal_id'] = mandalId;
    jsonData['village_id'] = villageId;
    jsonData['street_name'] = streetName;
    jsonData['pin_code'] = pinCode;
    jsonData['facing_direction'] = facingDirection;
    jsonData['price'] = price;
    jsonData['total_area'] = totalArea;
    jsonData['property_image'] = propertyImage;
    jsonData['person_name'] = personName;
    jsonData['person_number'] = personNumber;
    jsonData['property_desc'] = propertyDesc;
    jsonData['booking_amount'] = bookingAmount;
    jsonData['maintenance_charges'] = maintenanceCharges;
    jsonData['rera_number'] = reraNumber;
    jsonData['longitude'] = longitude;
    jsonData['latitude'] = latitude;
    jsonData['apartment_area'] = apartmentArea;
    jsonData['builtup_area'] = builtupArea;
    jsonData['bedrooms'] = bedrooms;
    jsonData['bathrooms'] = bathrooms;
    jsonData['parking'] = parking;
    jsonData['plot_area'] = plotArea;
    jsonData['plot_length'] = plotLength;
    jsonData['plot_width'] = plotWidth;
    jsonData['villa_builtup_area'] = villaBuiltupArea;
    jsonData['villa_floors'] = villaFloors;
    jsonData['villa_garden'] = villaGarden;
    jsonData['commercial_area'] = commercialArea;
    jsonData['floor_level'] = floorLevel;
    jsonData['suitable_for'] = suitableFor;
    jsonData['floor_plan_title'] = floorPlanTitle;
    jsonData['floor_plan_area'] = floorPlanArea;
    jsonData['floor_plan_image'] = floorPlanImage;
    jsonData['floor_plan_description'] = floorPlanDescription;
    jsonData['property_status_id'] = propertyStatusId;
    jsonData['active'] = active;
    jsonData['approved'] = approved;
    jsonData['posted_date'] = postedDate;
    jsonData['expiry_date'] = expiryDate;
    jsonData['added_by'] = addedBy;
    jsonData['added_by_role'] = addedByRole;
    jsonData['last_updated_by'] = lastUpdatedBy;
    jsonData['last_updated_by_role'] = lastUpdatedByRole;
    jsonData['last_updated_date_time'] = lastUpdatedDateTime;
    jsonData['inserted_ip'] = insertedIp;
    jsonData['updated_ip'] = updatedIp;
    return jsonData;
  }
}

// New classes for other lists in the data

class PropertyCategory {
  String? id;
  String? name;
  String? shortName;
  String? status;

  PropertyCategory({this.id, this.name, this.shortName, this.status});

  PropertyCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    shortName = json['short_name'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonData = {};
    jsonData['id'] = id;
    jsonData['name'] = name;
    jsonData['short_name'] = shortName;
    jsonData['status'] = status;
    return jsonData;
  }
}

class StateModel {
  String? id;
  String? name;
  String? status;

  StateModel({this.id, this.name, this.status});

  StateModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonData = {};
    jsonData['id'] = id;
    jsonData['name'] = name;
    jsonData['status'] = status;
    return jsonData;
  }
}

class District {
  String? id;
  String? name;
  String? status;

  District({this.id, this.name, this.status});

  District.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonData = {};
    jsonData['id'] = id;
    jsonData['name'] = name;
    jsonData['status'] = status;
    return jsonData;
  }
}

class Mandal {
  String? id;
  String? name;
  String? status;

  Mandal({this.id, this.name, this.status});

  Mandal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonData = {};
    jsonData['id'] = id;
    jsonData['name'] = name;
    jsonData['status'] = status;
    return jsonData;
  }
}

class Village {
  String? id;
  String? name;
  String? status;

  Village({this.id, this.name, this.status});

  Village.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonData = {};
    jsonData['id'] = id;
    jsonData['name'] = name;
    jsonData['status'] = status;
    return jsonData;
  }
}
