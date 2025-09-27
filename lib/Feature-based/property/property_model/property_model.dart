// // class GetAllProperties {
// //   bool? status;
// //   PropertiesData? data;
// //
// //   GetAllProperties({this.status, this.data});
// //
// //   factory GetAllProperties.fromJson(Map<String, dynamic> json) {
// //     return GetAllProperties(
// //       status: json['status'] as bool?,
// //       data: json['data'] != null ? PropertiesData.fromJson(json['data'] as Map<String, dynamic>) : null,
// //     );
// //   }
// //
// //   Map<String, dynamic> toJson() {
// //     final Map<String, dynamic> data = {};
// //     data['status'] = status;
// //     if (this.data != null) {
// //       data['data'] = this.data!.toJson();
// //     }
// //     return data;
// //   }
// // }
// //
// // class PropertiesData {
// //   List<Properties>? properties;
// //   List<PropertyCategory>? categories;
// //   List<State>? states;
// //   List<District>? districts;
// //   List<Mandal>? mandals;
// //   List<Village>? villages;
// //
// //   PropertiesData({
// //     this.properties,
// //     this.categories,
// //     this.states,
// //     this.districts,
// //     this.mandals,
// //     this.villages,
// //   });
// //
// //   factory PropertiesData.fromJson(Map<String, dynamic> json) {
// //     return PropertiesData(
// //       properties: json['properties'] != null
// //           ? (json['properties'] as List<dynamic>)
// //           .map((v) => Properties.fromJson(v as Map<String, dynamic>))
// //           .toList()
// //           : null,
// //       categories: json['properties_categories'] != null
// //           ? (json['properties_categories'] as List<dynamic>)
// //           .map((v) => PropertyCategory.fromJson(v as Map<String, dynamic>))
// //           .toList()
// //           : null,
// //       states: json['states'] != null
// //           ? (json['states'] as List<dynamic>)
// //           .map((v) => State.fromJson(v as Map<String, dynamic>))
// //           .toList()
// //           : null,
// //       districts: json['districts'] != null
// //           ? (json['districts'] as List<dynamic>)
// //           .map((v) => District.fromJson(v as Map<String, dynamic>))
// //           .toList()
// //           : null,
// //       mandals: json['mandals'] != null
// //           ? (json['mandals'] as List<dynamic>)
// //           .map((v) => Mandal.fromJson(v as Map<String, dynamic>))
// //           .toList()
// //           : null,
// //       villages: json['villages'] != null
// //           ? (json['villages'] as List<dynamic>)
// //           .map((v) => Village.fromJson(v as Map<String, dynamic>))
// //           .toList()
// //           : null,
// //     );
// //   }
// //
// //   Map<String, dynamic> toJson() {
// //     final Map<String, dynamic> data = {};
// //     if (properties != null) {
// //       data['properties'] = properties!.map((v) => v.toJson()).toList();
// //     }
// //     if (categories != null) {
// //       data['properties_categories'] = categories!.map((v) => v.toJson()).toList();
// //     }
// //     if (states != null) {
// //       data['states'] = states!.map((v) => v.toJson()).toList();
// //     }
// //     if (districts != null) {
// //       data['districts'] = districts!.map((v) => v.toJson()).toList();
// //     }
// //     if (mandals != null) {
// //       data['mandals'] = mandals!.map((v) => v.toJson()).toList();
// //     }
// //     if (villages != null) {
// //       data['villages'] = villages!.map((v) => v.toJson()).toList();
// //     }
// //     return data;
// //   }
// // }
// //
// // class Properties {
// //   String? id;
// //   String? addedDateTime;
// //   String? transactionDate;
// //   String? financialYearId;
// //   String? branchId;
// //   String? userId;
// //   String? refPrefix;
// //   String? referenceNumber;
// //   String? finalRefNumber;
// //   String? propertyCatId;
// //   String? propertyName;
// //   String? title;
// //   String? description;
// //   String? stateId;
// //   String? districtId;
// //   String? mandalId;
// //   String? villageId;
// //   String? streetName;
// //   String? pinCode;
// //   String? facingDirection;
// //   String? price;
// //   String? totalArea;
// //   String? propertyImage;
// //   String? personName;
// //   String? personNumber;
// //   String? propertyDesc;
// //   String? bookingAmount;
// //   String? maintenanceCharges;
// //   String? reraNumber;
// //   String? longitude;
// //   String? latitude;
// //   String? apartmentArea;
// //   String? builtupArea;
// //   String? bedrooms;
// //   String? bathrooms;
// //   String? parking;
// //   String? plotArea;
// //   String? plotLength;
// //   String? plotWidth;
// //   String? villaBuiltupArea;
// //   String? villaFloors;
// //   String? villaGarden;
// //   String? commercialArea;
// //   String? floorLevel;
// //   String? suitableFor;
// //   String? floorPlanTitle;
// //   String? floorPlanArea;
// //   String? floorPlanImage;
// //   String? floorPlanDescription;
// //   String? activeStatus;
// //   String? active;
// //   String? approved;
// //   String? postedDate;
// //   String? expiryDate;
// //   String? addedBy;
// //   String? addedByRole;
// //   String? lastUpdatedBy;
// //   String? lastUpdatedByRole;
// //   String? lastUpdatedDateTime;
// //   String? insertedIp;
// //   String? updatedIp;
// //
// //   Properties({
// //     this.id,
// //     this.addedDateTime,
// //     this.transactionDate,
// //     this.financialYearId,
// //     this.branchId,
// //     this.userId,
// //     this.refPrefix,
// //     this.referenceNumber,
// //     this.finalRefNumber,
// //     this.propertyCatId,
// //     this.propertyName,
// //     this.title,
// //     this.description,
// //     this.stateId,
// //     this.districtId,
// //     this.mandalId,
// //     this.villageId,
// //     this.streetName,
// //     this.pinCode,
// //     this.facingDirection,
// //     this.price,
// //     this.totalArea,
// //     this.propertyImage,
// //     this.personName,
// //     this.personNumber,
// //     this.propertyDesc,
// //     this.bookingAmount,
// //     this.maintenanceCharges,
// //     this.reraNumber,
// //     this.longitude,
// //     this.latitude,
// //     this.apartmentArea,
// //     this.builtupArea,
// //     this.bedrooms,
// //     this.bathrooms,
// //     this.parking,
// //     this.plotArea,
// //     this.plotLength,
// //     this.plotWidth,
// //     this.villaBuiltupArea,
// //     this.villaFloors,
// //     this.villaGarden,
// //     this.commercialArea,
// //     this.floorLevel,
// //     this.suitableFor,
// //     this.floorPlanTitle,
// //     this.floorPlanArea,
// //     this.floorPlanImage,
// //     this.floorPlanDescription,
// //     this.activeStatus,
// //     this.active,
// //     this.approved,
// //     this.postedDate,
// //     this.expiryDate,
// //     this.addedBy,
// //     this.addedByRole,
// //     this.lastUpdatedBy,
// //     this.lastUpdatedByRole,
// //     this.lastUpdatedDateTime,
// //     this.insertedIp,
// //     this.updatedIp,
// //   });
// //
// //   factory Properties.fromJson(Map<String, dynamic> json) {
// //     return Properties(
// //       id: json['id'] as String?,
// //       addedDateTime: json['added_date_time'] as String?,
// //       transactionDate: json['transaction_date'] as String?,
// //       financialYearId: json['financial_year_id'] as String?,
// //       branchId: json['branch_id'] as String?,
// //       userId: json['user_id'] as String?,
// //       refPrefix: json['ref_prefix'] as String?,
// //       referenceNumber: json['reference_number'] as String?,
// //       finalRefNumber: json['final_ref_number'] as String?,
// //       propertyCatId: json['property_cat_id'] as String?,
// //       propertyName: json['property_name'] as String?,
// //       title: json['title'] as String?,
// //       description: json['description'] as String?,
// //       stateId: json['state_id'] as String?,
// //       districtId: json['district_id'] as String?,
// //       mandalId: json['mandal_id'] as String?,
// //       villageId: json['village_id'] as String?,
// //       streetName: json['street_name'] as String?,
// //       pinCode: json['pin_code'] as String?,
// //       facingDirection: json['facing_direction'] as String?,
// //       price: json['price'] as String?,
// //       totalArea: json['total_area'] as String?,
// //       propertyImage: json['property_image'] as String?,
// //       personName: json['person_name'] as String?,
// //       personNumber: json['person_number'] as String?,
// //       propertyDesc: json['property_desc'] as String?,
// //       bookingAmount: json['booking_amount'] as String?,
// //       maintenanceCharges: json['maintenance_charges'] as String?,
// //       reraNumber: json['rera_number'] as String?,
// //       longitude: json['longitude'] as String?,
// //       latitude: json['latitude'] as String?,
// //       apartmentArea: json['apartment_area'] as String?,
// //       builtupArea: json['builtup_area'] as String?,
// //       bedrooms: json['bedrooms'] as String?,
// //       bathrooms: json['bathrooms'] as String?,
// //       parking: json['parking'] as String?,
// //       plotArea: json['plot_area'] as String?,
// //       plotLength: json['plot_length'] as String?,
// //       plotWidth: json['plot_width'] as String?,
// //       villaBuiltupArea: json['villa_builtup_area'] as String?,
// //       villaFloors: json['villa_floors'] as String?,
// //       villaGarden: json['villa_garden'] as String?,
// //       commercialArea: json['commercial_area'] as String?,
// //       floorLevel: json['floor_level'] as String?,
// //       suitableFor: json['suitable_for'] as String?,
// //       floorPlanTitle: json['floor_plan_title'] as String?,
// //       floorPlanArea: json['floor_plan_area'] as String?,
// //       floorPlanImage: json['floor_plan_image'] as String?,
// //       floorPlanDescription: json['floor_plan_description'] as String?,
// //       activeStatus: json['active_status'] as String?,
// //       active: json['active'] as String?,
// //       approved: json['approved'] as String?,
// //       postedDate: json['posted_date'] as String?,
// //       expiryDate: json['expiry_date'] as String?,
// //       addedBy: json['added_by'] as String?,
// //       addedByRole: json['added_by_role'] as String?,
// //       lastUpdatedBy: json['last_updated_by'] as String?,
// //       lastUpdatedByRole: json['last_updated_by_role'] as String?,
// //       lastUpdatedDateTime: json['last_updated_date_time'] as String?,
// //       insertedIp: json['inserted_ip'] as String?,
// //       updatedIp: json['updated_ip'] as String?,
// //     );
// //   }
// //
// //   Map<String, dynamic> toJson() {
// //     final Map<String, dynamic> data = {};
// //     data['id'] = id;
// //     data['added_date_time'] = addedDateTime;
// //     data['transaction_date'] = transactionDate;
// //     data['financial_year_id'] = financialYearId;
// //     data['branch_id'] = branchId;
// //     data['user_id'] = userId;
// //     data['ref_prefix'] = refPrefix;
// //     data['reference_number'] = referenceNumber;
// //     data['final_ref_number'] = finalRefNumber;
// //     data['property_cat_id'] = propertyCatId;
// //     data['property_name'] = propertyName;
// //     data['title'] = title;
// //     data['description'] = description;
// //     data['state_id'] = stateId;
// //     data['district_id'] = districtId;
// //     data['mandal_id'] = mandalId;
// //     data['village_id'] = villageId;
// //     data['street_name'] = streetName;
// //     data['pin_code'] = pinCode;
// //     data['facing_direction'] = facingDirection;
// //     data['price'] = price;
// //     data['total_area'] = totalArea;
// //     data['property_image'] = propertyImage;
// //     data['person_name'] = personName;
// //     data['person_number'] = personNumber;
// //     data['property_desc'] = propertyDesc;
// //     data['booking_amount'] = bookingAmount;
// //     data['maintenance_charges'] = maintenanceCharges;
// //     data['rera_number'] = reraNumber;
// //     data['longitude'] = longitude;
// //     data['latitude'] = latitude;
// //     data['apartment_area'] = apartmentArea;
// //     data['builtup_area'] = builtupArea;
// //     data['bedrooms'] = bedrooms;
// //     data['bathrooms'] = bathrooms;
// //     data['parking'] = parking;
// //     data['plot_area'] = plotArea;
// //     data['plot_length'] = plotLength;
// //     data['plot_width'] = plotWidth;
// //     data['villa_builtup_area'] = villaBuiltupArea;
// //     data['villa_floors'] = villaFloors;
// //     data['villa_garden'] = villaGarden;
// //     data['commercial_area'] = commercialArea;
// //     data['floor_level'] = floorLevel;
// //     data['suitable_for'] = suitableFor;
// //     data['floor_plan_title'] = floorPlanTitle;
// //     data['floor_plan_area'] = floorPlanArea;
// //     data['floor_plan_image'] = floorPlanImage;
// //     data['floor_plan_description'] = floorPlanDescription;
// //     data['active_status'] = activeStatus;
// //     data['active'] = active;
// //     data['approved'] = approved;
// //     data['posted_date'] = postedDate;
// //     data['expiry_date'] = expiryDate;
// //     data['added_by'] = addedBy;
// //     data['added_by_role'] = addedByRole;
// //     data['last_updated_by'] = lastUpdatedBy;
// //     data['last_updated_by_role'] = lastUpdatedByRole;
// //     data['last_updated_date_time'] = lastUpdatedDateTime;
// //     data['inserted_ip'] = insertedIp;
// //     data['updated_ip'] = updatedIp;
// //     return data;
// //   }
// // }
// //
// // class PropertyCategory {
// //   String? id;
// //   String? addedDateTime;
// //   String? branchId;
// //   String? financialYearId;
// //   String? propertyCategoryTitle;
// //   String? addedBy;
// //   String? addedByRole;
// //   String? insertedIp;
// //   String? lastUpdatedDateTime;
// //   String? lastUpdatedBy;
// //   String? lastUpdatedByRole;
// //   String? updatedIp;
// //
// //   PropertyCategory({
// //     this.id,
// //     this.addedDateTime,
// //     this.branchId,
// //     this.financialYearId,
// //     this.propertyCategoryTitle,
// //     this.addedBy,
// //     this.addedByRole,
// //     this.insertedIp,
// //     this.lastUpdatedDateTime,
// //     this.lastUpdatedBy,
// //     this.lastUpdatedByRole,
// //     this.updatedIp,
// //   });
// //
// //   factory PropertyCategory.fromJson(Map<String, dynamic> json) {
// //     return PropertyCategory(
// //       id: json['id'] as String?,
// //       addedDateTime: json['added_date_time'] as String?,
// //       branchId: json['branch_id'] as String?,
// //       financialYearId: json['financial_year_id'] as String?,
// //       propertyCategoryTitle: json['property_category_title'] as String?,
// //       addedBy: json['added_by'] as String?,
// //       addedByRole: json['added_by_role'] as String?,
// //       insertedIp: json['inserted_ip'] as String?,
// //       lastUpdatedDateTime: json['last_updated_date_time'] as String?,
// //       lastUpdatedBy: json['last_updated_by'] as String?,
// //       lastUpdatedByRole: json['last_updated_by_role'] as String?,
// //       updatedIp: json['updated_ip'] as String?,
// //     );
// //   }
// //
// //   Map<String, dynamic> toJson() {
// //     final Map<String, dynamic> data = {};
// //     data['id'] = id;
// //     data['added_date_time'] = addedDateTime;
// //     data['branch_id'] = branchId;
// //     data['financial_year_id'] = financialYearId;
// //     data['property_category_title'] = propertyCategoryTitle;
// //     data['added_by'] = addedBy;
// //     data['added_by_role'] = addedByRole;
// //     data['inserted_ip'] = insertedIp;
// //     data['last_updated_date_time'] = lastUpdatedDateTime;
// //     data['last_updated_by'] = lastUpdatedBy;
// //     data['last_updated_by_role'] = lastUpdatedByRole;
// //     data['updated_ip'] = updatedIp;
// //     return data;
// //   }
// // }
// //
// // class State {
// //   String? id;
// //   String? addedDateTime;
// //   String? transactionDate;
// //   String? financialYearId;
// //   String? branchId;
// //   String? stateName;
// //   String? activeStatus;
// //   String? addedBy;
// //   String? addedByRole;
// //   String? insertedIp;
// //   String? lastUpdatedDateTime;
// //   String? lastUpdatedBy;
// //   String? lastUpdatedByRole;
// //   String? updatedIp;
// //
// //   State({
// //     this.id,
// //     this.addedDateTime,
// //     this.transactionDate,
// //     this.financialYearId,
// //     this.branchId,
// //     this.stateName,
// //     this.activeStatus,
// //     this.addedBy,
// //     this.addedByRole,
// //     this.insertedIp,
// //     this.lastUpdatedDateTime,
// //     this.lastUpdatedBy,
// //     this.lastUpdatedByRole,
// //     this.updatedIp,
// //   });
// //
// //   factory State.fromJson(Map<String, dynamic> json) {
// //     return State(
// //       id: json['id'] as String?,
// //       addedDateTime: json['added_date_time'] as String?,
// //       transactionDate: json['transaction_date'] as String?,
// //       financialYearId: json['financial_year_id'] as String?,
// //       branchId: json['branch_id'] as String?,
// //       stateName: json['state_name'] as String?,
// //       activeStatus: json['active_status'] as String?,
// //       addedBy: json['added_by'] as String?,
// //       addedByRole: json['added_by_role'] as String?,
// //       insertedIp: json['inserted_ip'] as String?,
// //       lastUpdatedDateTime: json['last_updated_date_time'] as String?,
// //       lastUpdatedBy: json['last_updated_by'] as String?,
// //       lastUpdatedByRole: json['last_updated_by_role'] as String?,
// //       updatedIp: json['updated_ip'] as String?,
// //     );
// //   }
// //
// //   Map<String, dynamic> toJson() {
// //     final Map<String, dynamic> data = {};
// //     data['id'] = id;
// //     data['added_date_time'] = addedDateTime;
// //     data['transaction_date'] = transactionDate;
// //     data['financial_year_id'] = financialYearId;
// //     data['branch_id'] = branchId;
// //     data['state_name'] = stateName;
// //     data['active_status'] = activeStatus;
// //     data['added_by'] = addedBy;
// //     data['added_by_role'] = addedByRole;
// //     data['inserted_ip'] = insertedIp;
// //     data['last_updated_date_time'] = lastUpdatedDateTime;
// //     data['last_updated_by'] = lastUpdatedBy;
// //     data['last_updated_by_role'] = lastUpdatedByRole;
// //     data['updated_ip'] = updatedIp;
// //     return data;
// //   }
// // }
// //
// // class District {
// //   String? id;
// //   String? addedDateTime;
// //   String? transactionDate;
// //   String? financialYearId;
// //   String? branchId;
// //   String? stateId;
// //   String? districtName;
// //   String? activeStatus;
// //   String? addedBy;
// //   String? addedByRole;
// //   String? lastUpdatedBy;
// //   String? lastUpdatedByRole;
// //   String? lastUpdatedDateTime;
// //   String? insertedIp;
// //   String? updatedIp;
// //
// //   District({
// //     this.id,
// //     this.addedDateTime,
// //     this.transactionDate,
// //     this.financialYearId,
// //     this.branchId,
// //     this.stateId,
// //     this.districtName,
// //     this.activeStatus,
// //     this.addedBy,
// //     this.addedByRole,
// //     this.lastUpdatedBy,
// //     this.lastUpdatedByRole,
// //     this.lastUpdatedDateTime,
// //     this.insertedIp,
// //     this.updatedIp,
// //   });
// //
// //   factory District.fromJson(Map<String, dynamic> json) {
// //     return District(
// //       id: json['id'] as String?,
// //       addedDateTime: json['added_date_time'] as String?,
// //       transactionDate: json['transaction_date'] as String?,
// //       financialYearId: json['financial_year_id'] as String?,
// //       branchId: json['branch_id'] as String?,
// //       stateId: json['state_id'] as String?,
// //       districtName: json['district_name'] as String?,
// //       activeStatus: json['active_status'] as String?,
// //       addedBy: json['added_by'] as String?,
// //       addedByRole: json['added_by_role'] as String?,
// //       lastUpdatedBy: json['last_updated_by'] as String?,
// //       lastUpdatedByRole: json['last_updated_by_role'] as String?,
// //       lastUpdatedDateTime: json['last_updated_date_time'] as String?,
// //       insertedIp: json['inserted_ip'] as String?,
// //       updatedIp: json['updated_ip'] as String?,
// //     );
// //   }
// //
// //   Map<String, dynamic> toJson() {
// //     final Map<String, dynamic> data = {};
// //     data['id'] = id;
// //     data['added_date_time'] = addedDateTime;
// //     data['transaction_date'] = transactionDate;
// //     data['financial_year_id'] = financialYearId;
// //     data['branch_id'] = branchId;
// //     data['state_id'] = stateId;
// //     data['district_name'] = districtName;
// //     data['active_status'] = activeStatus;
// //     data['added_by'] = addedBy;
// //     data['added_by_role'] = addedByRole;
// //     data['last_updated_by'] = lastUpdatedBy;
// //     data['last_updated_by_role'] = lastUpdatedByRole;
// //     data['last_updated_date_time'] = lastUpdatedDateTime;
// //     data['inserted_ip'] = insertedIp;
// //     data['updated_ip'] = updatedIp;
// //     return data;
// //   }
// // }
// //
// // class Mandal {
// //   String? id;
// //   String? addedDateTime;
// //   String? transactionDate;
// //   String? financialYearId;
// //   String? branchId;
// //   String? stateId;
// //   String? districtId;
// //   String? mandalName;
// //   String? activeStatus;
// //   String? addedBy;
// //   String? addedByRole;
// //   String? lastUpdatedBy;
// //   String? lastUpdatedByRole;
// //   String? lastUpdatedDateTime;
// //   String? insertedIp;
// //   String? updatedIp;
// //
// //   Mandal({
// //     this.id,
// //     this.addedDateTime,
// //     this.transactionDate,
// //     this.financialYearId,
// //     this.branchId,
// //     this.stateId,
// //     this.districtId,
// //     this.mandalName,
// //     this.activeStatus,
// //     this.addedBy,
// //     this.addedByRole,
// //     this.lastUpdatedBy,
// //     this.lastUpdatedByRole,
// //     this.lastUpdatedDateTime,
// //     this.insertedIp,
// //     this.updatedIp,
// //   });
// //
// //   factory Mandal.fromJson(Map<String, dynamic> json) {
// //     return Mandal(
// //       id: json['id'] as String?,
// //       addedDateTime: json['added_date_time'] as String?,
// //       transactionDate: json['transaction_date'] as String?,
// //       financialYearId: json['financial_year_id'] as String?,
// //       branchId: json['branch_id'] as String?,
// //       stateId: json['state_id'] as String?,
// //       districtId: json['district_id'] as String?,
// //       mandalName: json['mandal_name'] as String?,
// //       activeStatus: json['active_status'] as String?,
// //       addedBy: json['added_by'] as String?,
// //       addedByRole: json['added_by_role'] as String?,
// //       lastUpdatedBy: json['last_updated_by'] as String?,
// //       lastUpdatedByRole: json['last_updated_by_role'] as String?,
// //       lastUpdatedDateTime: json['last_updated_date_time'] as String?,
// //       insertedIp: json['inserted_ip'] as String?,
// //       updatedIp: json['updated_ip'] as String?,
// //     );
// //   }
// //
// //   Map<String, dynamic> toJson() {
// //     final Map<String, dynamic> data = {};
// //     data['id'] = id;
// //     data['added_date_time'] = addedDateTime;
// //     data['transaction_date'] = transactionDate;
// //     data['financial_year_id'] = financialYearId;
// //     data['branch_id'] = branchId;
// //     data['state_id'] = stateId;
// //     data['district_id'] = districtId;
// //     data['mandal_name'] = mandalName;
// //     data['active_status'] = activeStatus;
// //     data['added_by'] = addedBy;
// //     data['added_by_role'] = addedByRole;
// //     data['last_updated_by'] = lastUpdatedBy;
// //     data['last_updated_by_role'] = lastUpdatedByRole;
// //     data['last_updated_date_time'] = lastUpdatedDateTime;
// //     data['inserted_ip'] = insertedIp;
// //     data['updated_ip'] = updatedIp;
// //     return data;
// //   }
// // }
// //
// // class Village {
// //   String? id;
// //   String? addedDateTime;
// //   String? transactionDate;
// //   String? financialYearId;
// //   String? branchId;
// //   String? stateId;
// //   String? districtId;
// //   String? mandalId;
// //   String? villageName;
// //   String? pinCode;
// //   String? activeStatus;
// //   String? addedBy;
// //   String? addedByRole;
// //   String? lastUpdatedBy;
// //   String? lastUpdatedByRole;
// //   String? lastUpdatedDateTime;
// //   String? insertedIp;
// //   String? updatedIp;
// //
// //   Village({
// //     this.id,
// //     this.addedDateTime,
// //     this.transactionDate,
// //     this.financialYearId,
// //     this.branchId,
// //     this.stateId,
// //     this.districtId,
// //     this.mandalId,
// //     this.villageName,
// //     this.pinCode,
// //     this.activeStatus,
// //     this.addedBy,
// //     this.addedByRole,
// //     this.lastUpdatedBy,
// //     this.lastUpdatedByRole,
// //     this.lastUpdatedDateTime,
// //     this.insertedIp,
// //     this.updatedIp,
// //   });
// //
// //   factory Village.fromJson(Map<String, dynamic> json) {
// //     return Village(
// //       id: json['id'] as String?,
// //       addedDateTime: json['added_date_time'] as String?,
// //       transactionDate: json['transaction_date'] as String?,
// //       financialYearId: json['financial_year_id'] as String?,
// //       branchId: json['branch_id'] as String?,
// //       stateId: json['state_id'] as String?,
// //       districtId: json['district_id'] as String?,
// //       mandalId: json['mandal_id'] as String?,
// //       villageName: json['village_name'] as String?,
// //       pinCode: json['pin_code'] as String?,
// //       activeStatus: json['active_status'] as String?,
// //       addedBy: json['added_by'] as String?,
// //       addedByRole: json['added_by_role'] as String?,
// //       lastUpdatedBy: json['last_updated_by'] as String?,
// //       lastUpdatedByRole: json['last_updated_by_role'] as String?,
// //       lastUpdatedDateTime: json['last_updated_date_time'] as String?,
// //       insertedIp: json['inserted_ip'] as String?,
// //       updatedIp: json['updated_ip'] as String?,
// //     );
// //   }
// //
// //   Map<String, dynamic> toJson() {
// //     final Map<String, dynamic> data = {};
// //     data['id'] = id;
// //     data['added_date_time'] = addedDateTime;
// //     data['transaction_date'] = transactionDate;
// //     data['financial_year_id'] = financialYearId;
// //     data['branch_id'] = branchId;
// //     data['state_id'] = stateId;
// //     data['district_id'] = districtId;
// //     data['mandal_id'] = mandalId;
// //     data['village_name'] = villageName;
// //     data['pin_code'] = pinCode;
// //     data['active_status'] = activeStatus;
// //     data['added_by'] = addedBy;
// //     data['added_by_role'] = addedByRole;
// //     data['last_updated_by'] = lastUpdatedBy;
// //     data['last_updated_by_role'] = lastUpdatedByRole;
// //     data['last_updated_date_time'] = lastUpdatedDateTime;
// //     data['inserted_ip'] = insertedIp;
// //     data['updated_ip'] = updatedIp;
// //     return data;
// //   }
// // }
//
//
//
//
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
//
// import 'package:provider/provider.dart';
//
// // Property Model (from previous response)
//
// class GetAllProperties {
//   bool? status;
//   PropertiesData? data;
//
//   GetAllProperties({this.status, this.data});
//
//   factory GetAllProperties.fromJson(Map<String, dynamic> json) {
//     return GetAllProperties(
//       status: json['status'] as bool?,
//       data: json['data'] != null ? PropertiesData.fromJson(json['data'] as Map<String, dynamic>) : null,
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = {};
//     data['status'] = status;
//     if (this.data != null) {
//       data['data'] = this.data!.toJson();
//     }
//     return data;
//   }
// }
//
// class PropertiesData {
//   List<Properties>? properties;
//   List<PropertyCategory>? categories;
//   List<State>? states;
//   List<District>? districts;
//   List<Mandal>? mandals;
//   List<Village>? villages;
//
//   PropertiesData({
//     this.properties,
//     this.categories,
//     this.states,
//     this.districts,
//     this.mandals,
//     this.villages,
//   });
//
//   factory PropertiesData.fromJson(Map<String, dynamic> json) {
//     return PropertiesData(
//       properties: json['properties'] != null
//           ? (json['properties'] as List<dynamic>)
//           .map((v) => Properties.fromJson(v as Map<String, dynamic>))
//           .toList()
//           : null,
//       categories: json['properties_categories'] != null
//           ? (json['properties_categories'] as List<dynamic>)
//           .map((v) => PropertyCategory.fromJson(v as Map<String, dynamic>))
//           .toList()
//           : null,
//       states: json['states'] != null
//           ? (json['states'] as List<dynamic>)
//           .map((v) => State.fromJson(v as Map<String, dynamic>))
//           .toList()
//           : null,
//       districts: json['districts'] != null
//           ? (json['districts'] as List<dynamic>)
//           .map((v) => District.fromJson(v as Map<String, dynamic>))
//           .toList()
//           : null,
//       mandals: json['mandals'] != null
//           ? (json['mandals'] as List<dynamic>)
//           .map((v) => Mandal.fromJson(v as Map<String, dynamic>))
//           .toList()
//           : null,
//       villages: json['villages'] != null
//           ? (json['villages'] as List<dynamic>)
//           .map((v) => Village.fromJson(v as Map<String, dynamic>))
//           .toList()
//           : null,
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = {};
//     if (properties != null) {
//       data['properties'] = properties!.map((v) => v.toJson()).toList();
//     }
//     if (categories != null) {
//       data['properties_categories'] = categories!.map((v) => v.toJson()).toList();
//     }
//     if (states != null) {
//       data['states'] = states!.map((v) => v.toJson()).toList();
//     }
//     if (districts != null) {
//       data['districts'] = districts!.map((v) => v.toJson()).toList();
//     }
//     if (mandals != null) {
//       data['mandals'] = mandals!.map((v) => v.toJson()).toList();
//     }
//     if (villages != null) {
//       data['villages'] = villages!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class Properties {
//   String? id;
//   String? addedDateTime;
//   String? transactionDate;
//   String? financialYearId;
//   String? branchId;
//   String? userId;
//   String? refPrefix;
//   String? referenceNumber;
//   String? finalRefNumber;
//   String? propertyCatId;
//   String? propertyName;
//   String? title;
//   String? description;
//   String? stateId;
//   String? districtId;
//   String? mandalId;
//   String? villageId;
//   String? streetName;
//   String? pinCode;
//   String? facingDirection;
//   String? price;
//   String? totalArea;
//   String? propertyImage;
//   String? personName;
//   String? personNumber;
//   String? propertyDesc;
//   String? bookingAmount;
//   String? maintenanceCharges;
//   String? reraNumber;
//   String? longitude;
//   String? latitude;
//   String? apartmentArea;
//   String? builtupArea;
//   String? bedrooms;
//   String? bathrooms;
//   String? parking;
//   String? plotArea;
//   String? plotLength;
//   String? plotWidth;
//   String? villaBuiltupArea;
//   String? villaFloors;
//   String? villaGarden;
//   String? commercialArea;
//   String? floorLevel;
//   String? suitableFor;
//   String? floorPlanTitle;
//   String? floorPlanArea;
//   String? floorPlanImage;
//   String? floorPlanDescription;
//   String? activeStatus;
//   String? active;
//   String? approved;
//   String? postedDate;
//   String? expiryDate;
//   String? addedBy;
//   String? addedByRole;
//   String? lastUpdatedBy;
//   String? lastUpdatedByRole;
//   String? lastUpdatedDateTime;
//   String? insertedIp;
//   String? updatedIp;
//
//   Properties({
//     this.id,
//     this.addedDateTime,
//     this.transactionDate,
//     this.financialYearId,
//     this.branchId,
//     this.userId,
//     this.refPrefix,
//     this.referenceNumber,
//     this.finalRefNumber,
//     this.propertyCatId,
//     this.propertyName,
//     this.title,
//     this.description,
//     this.stateId,
//     this.districtId,
//     this.mandalId,
//     this.villageId,
//     this.streetName,
//     this.pinCode,
//     this.facingDirection,
//     this.price,
//     this.totalArea,
//     this.propertyImage,
//     this.personName,
//     this.personNumber,
//     this.propertyDesc,
//     this.bookingAmount,
//     this.maintenanceCharges,
//     this.reraNumber,
//     this.longitude,
//     this.latitude,
//     this.apartmentArea,
//     this.builtupArea,
//     this.bedrooms,
//     this.bathrooms,
//     this.parking,
//     this.plotArea,
//     this.plotLength,
//     this.plotWidth,
//     this.villaBuiltupArea,
//     this.villaFloors,
//     this.villaGarden,
//     this.commercialArea,
//     this.floorLevel,
//     this.suitableFor,
//     this.floorPlanTitle,
//     this.floorPlanArea,
//     this.floorPlanImage,
//     this.floorPlanDescription,
//     this.activeStatus,
//     this.active,
//     this.approved,
//     this.postedDate,
//     this.expiryDate,
//     this.addedBy,
//     this.addedByRole,
//     this.lastUpdatedBy,
//     this.lastUpdatedByRole,
//     this.lastUpdatedDateTime,
//     this.insertedIp,
//     this.updatedIp,
//   });
//
//   factory Properties.fromJson(Map<String, dynamic> json) {
//     return Properties(
//       id: json['id'] as String?,
//       addedDateTime: json['added_date_time'] as String?,
//       transactionDate: json['transaction_date'] as String?,
//       financialYearId: json['financial_year_id'] as String?,
//       branchId: json['branch_id'] as String?,
//       userId: json['user_id'] as String?,
//       refPrefix: json['ref_prefix'] as String?,
//       referenceNumber: json['reference_number'] as String?,
//       finalRefNumber: json['final_ref_number'] as String?,
//       propertyCatId: json['property_cat_id'] as String?,
//       propertyName: json['property_name'] as String?,
//       title: json['title'] as String?,
//       description: json['description'] as String?,
//       stateId: json['state_id'] as String?,
//       districtId: json['district_id'] as String?,
//       mandalId: json['mandal_id'] as String?,
//       villageId: json['village_id'] as String?,
//       streetName: json['street_name'] as String?,
//       pinCode: json['pin_code'] as String?,
//       facingDirection: json['facing_direction'] as String?,
//       price: json['price'] as String?,
//       totalArea: json['total_area'] as String?,
//       propertyImage: json['property_image'] as String?,
//       personName: json['person_name'] as String?,
//       personNumber: json['person_number'] as String?,
//       propertyDesc: json['property_desc'] as String?,
//       bookingAmount: json['booking_amount'] as String?,
//       maintenanceCharges: json['maintenance_charges'] as String?,
//       reraNumber: json['rera_number'] as String?,
//       longitude: json['longitude'] as String?,
//       latitude: json['latitude'] as String?,
//       apartmentArea: json['apartment_area'] as String?,
//       builtupArea: json['builtup_area'] as String?,
//       bedrooms: json['bedrooms'] as String?,
//       bathrooms: json['bathrooms'] as String?,
//       parking: json['parking'] as String?,
//       plotArea: json['plot_area'] as String?,
//       plotLength: json['plot_length'] as String?,
//       plotWidth: json['plot_width'] as String?,
//       villaBuiltupArea: json['villa_builtup_area'] as String?,
//       villaFloors: json['villa_floors'] as String?,
//       villaGarden: json['villa_garden'] as String?,
//       commercialArea: json['commercial_area'] as String?,
//       floorLevel: json['floor_level'] as String?,
//       suitableFor: json['suitable_for'] as String?,
//       floorPlanTitle: json['floor_plan_title'] as String?,
//       floorPlanArea: json['floor_plan_area'] as String?,
//       floorPlanImage: json['floor_plan_image'] as String?,
//       floorPlanDescription: json['floor_plan_description'] as String?,
//       activeStatus: json['active_status'] as String?,
//       active: json['active'] as String?,
//       approved: json['approved'] as String?,
//       postedDate: json['posted_date'] as String?,
//       expiryDate: json['expiry_date'] as String?,
//       addedBy: json['added_by'] as String?,
//       addedByRole: json['added_by_role'] as String?,
//       lastUpdatedBy: json['last_updated_by'] as String?,
//       lastUpdatedByRole: json['last_updated_by_role'] as String?,
//       lastUpdatedDateTime: json['last_updated_date_time'] as String?,
//       insertedIp: json['inserted_ip'] as String?,
//       updatedIp: json['updated_ip'] as String?,
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = {};
//     data['id'] = id;
//     data['added_date_time'] = addedDateTime;
//     data['transaction_date'] = transactionDate;
//     data['financial_year_id'] = financialYearId;
//     data['branch_id'] = branchId;
//     data['user_id'] = userId;
//     data['ref_prefix'] = refPrefix;
//     data['reference_number'] = referenceNumber;
//     data['final_ref_number'] = finalRefNumber;
//     data['property_cat_id'] = propertyCatId;
//     data['property_name'] = propertyName;
//     data['title'] = title;
//     data['description'] = description;
//     data['state_id'] = stateId;
//     data['district_id'] = districtId;
//     data['mandal_id'] = mandalId;
//     data['village_id'] = villageId;
//     data['street_name'] = streetName;
//     data['pin_code'] = pinCode;
//     data['facing_direction'] = facingDirection;
//     data['price'] = price;
//     data['total_area'] = totalArea;
//     data['property_image'] = propertyImage;
//     data['person_name'] = personName;
//     data['person_number'] = personNumber;
//     data['property_desc'] = propertyDesc;
//     data['booking_amount'] = bookingAmount;
//     data['maintenance_charges'] = maintenanceCharges;
//     data['rera_number'] = reraNumber;
//     data['longitude'] = longitude;
//     data['latitude'] = latitude;
//     data['apartment_area'] = apartmentArea;
//     data['builtup_area'] = builtupArea;
//     data['bedrooms'] = bedrooms;
//     data['bathrooms'] = bathrooms;
//     data['parking'] = parking;
//     data['plot_area'] = plotArea;
//     data['plot_length'] = plotLength;
//     data['plot_width'] = plotWidth;
//     data['villa_builtup_area'] = villaBuiltupArea;
//     data['villa_floors'] = villaFloors;
//     data['villa_garden'] = villaGarden;
//     data['commercial_area'] = commercialArea;
//     data['floor_level'] = floorLevel;
//     data['suitable_for'] = suitableFor;
//     data['floor_plan_title'] = floorPlanTitle;
//     data['floor_plan_area'] = floorPlanArea;
//     data['floor_plan_image'] = floorPlanImage;
//     data['floor_plan_description'] = floorPlanDescription;
//     data['active_status'] = activeStatus;
//     data['active'] = active;
//     data['approved'] = approved;
//     data['posted_date'] = postedDate;
//     data['expiry_date'] = expiryDate;
//     data['added_by'] = addedBy;
//     data['added_by_role'] = addedByRole;
//     data['last_updated_by'] = lastUpdatedBy;
//     data['last_updated_by_role'] = lastUpdatedByRole;
//     data['last_updated_date_time'] = lastUpdatedDateTime;
//     data['inserted_ip'] = insertedIp;
//     data['updated_ip'] = updatedIp;
//     return data;
//   }
// }
//
// class PropertyCategory {
//   String? id;
//   String? addedDateTime;
//   String? branchId;
//   String? financialYearId;
//   String? propertyCategoryTitle;
//   String? addedBy;
//   String? addedByRole;
//   String? insertedIp;
//   String? lastUpdatedDateTime;
//   String? lastUpdatedBy;
//   String? lastUpdatedByRole;
//   String? updatedIp;
//
//   PropertyCategory({
//     this.id,
//     this.addedDateTime,
//     this.branchId,
//     this.financialYearId,
//     this.propertyCategoryTitle,
//     this.addedBy,
//     this.addedByRole,
//     this.insertedIp,
//     this.lastUpdatedDateTime,
//     this.lastUpdatedBy,
//     this.lastUpdatedByRole,
//     this.updatedIp,
//   });
//
//   factory PropertyCategory.fromJson(Map<String, dynamic> json) {
//     return PropertyCategory(
//       id: json['id'] as String?,
//       addedDateTime: json['added_date_time'] as String?,
//       branchId: json['branch_id'] as String?,
//       financialYearId: json['financial_year_id'] as String?,
//       propertyCategoryTitle: json['property_category_title'] as String?,
//       addedBy: json['added_by'] as String?,
//       addedByRole: json['added_by_role'] as String?,
//       insertedIp: json['inserted_ip'] as String?,
//       lastUpdatedDateTime: json['last_updated_date_time'] as String?,
//       lastUpdatedBy: json['last_updated_by'] as String?,
//       lastUpdatedByRole: json['last_updated_by_role'] as String?,
//       updatedIp: json['updated_ip'] as String?,
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = {};
//     data['id'] = id;
//     data['added_date_time'] = addedDateTime;
//     data['branch_id'] = branchId;
//     data['financial_year_id'] = financialYearId;
//     data['property_category_title'] = propertyCategoryTitle;
//     data['added_by'] = addedBy;
//     data['added_by_role'] = addedByRole;
//     data['inserted_ip'] = insertedIp;
//     data['last_updated_date_time'] = lastUpdatedDateTime;
//     data['last_updated_by'] = lastUpdatedBy;
//     data['last_updated_by_role'] = lastUpdatedByRole;
//     data['updated_ip'] = updatedIp;
//     return data;
//   }
// }
//
// class State {
//   String? id;
//   String? addedDateTime;
//   String? transactionDate;
//   String? financialYearId;
//   String? branchId;
//   String? stateName;
//   String? activeStatus;
//   String? addedBy;
//   String? addedByRole;
//   String? insertedIp;
//   String? lastUpdatedDateTime;
//   String? lastUpdatedBy;
//   String? lastUpdatedByRole;
//   String? updatedIp;
//
//   State({
//     this.id,
//     this.addedDateTime,
//     this.transactionDate,
//     this.financialYearId,
//     this.branchId,
//     this.stateName,
//     this.activeStatus,
//     this.addedBy,
//     this.addedByRole,
//     this.insertedIp,
//     this.lastUpdatedDateTime,
//     this.lastUpdatedBy,
//     this.lastUpdatedByRole,
//     this.updatedIp,
//   });
//
//   factory State.fromJson(Map<String, dynamic> json) {
//     return State(
//       id: json['id'] as String?,
//       addedDateTime: json['added_date_time'] as String?,
//       transactionDate: json['transaction_date'] as String?,
//       financialYearId: json['financial_year_id'] as String?,
//       branchId: json['branch_id'] as String?,
//       stateName: json['state_name'] as String?,
//       activeStatus: json['active_status'] as String?,
//       addedBy: json['added_by'] as String?,
//       addedByRole: json['added_by_role'] as String?,
//       insertedIp: json['inserted_ip'] as String?,
//       lastUpdatedDateTime: json['last_updated_date_time'] as String?,
//       lastUpdatedBy: json['last_updated_by'] as String?,
//       lastUpdatedByRole: json['last_updated_by_role'] as String?,
//       updatedIp: json['updated_ip'] as String?,
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = {};
//     data['id'] = id;
//     data['added_date_time'] = addedDateTime;
//     data['transaction_date'] = transactionDate;
//     data['financial_year_id'] = financialYearId;
//     data['branch_id'] = branchId;
//     data['state_name'] = stateName;
//     data['active_status'] = activeStatus;
//     data['added_by'] = addedBy;
//     data['added_by_role'] = addedByRole;
//     data['inserted_ip'] = insertedIp;
//     data['last_updated_date_time'] = lastUpdatedDateTime;
//     data['last_updated_by'] = lastUpdatedBy;
//     data['last_updated_by_role'] = lastUpdatedByRole;
//     data['updated_ip'] = updatedIp;
//     return data;
//   }
// }
//
// class District {
//   String? id;
//   String? addedDateTime;
//   String? transactionDate;
//   String? financialYearId;
//   String? branchId;
//   String? stateId;
//   String? districtName;
//   String? activeStatus;
//   String? addedBy;
//   String? addedByRole;
//   String? lastUpdatedBy;
//   String? lastUpdatedByRole;
//   String? lastUpdatedDateTime;
//   String? insertedIp;
//   String? updatedIp;
//
//   District({
//     this.id,
//     this.addedDateTime,
//     this.transactionDate,
//     this.financialYearId,
//     this.branchId,
//     this.stateId,
//     this.districtName,
//     this.activeStatus,
//     this.addedBy,
//     this.addedByRole,
//     this.lastUpdatedBy,
//     this.lastUpdatedByRole,
//     this.lastUpdatedDateTime,
//     this.insertedIp,
//     this.updatedIp,
//   });
//
//   factory District.fromJson(Map<String, dynamic> json) {
//     return District(
//       id: json['id'] as String?,
//       addedDateTime: json['added_date_time'] as String?,
//       transactionDate: json['transaction_date'] as String?,
//       financialYearId: json['financial_year_id'] as String?,
//       branchId: json['branch_id'] as String?,
//       stateId: json['state_id'] as String?,
//       districtName: json['district_name'] as String?,
//       activeStatus: json['active_status'] as String?,
//       addedBy: json['added_by'] as String?,
//       addedByRole: json['added_by_role'] as String?,
//       lastUpdatedBy: json['last_updated_by'] as String?,
//       lastUpdatedByRole: json['last_updated_by_role'] as String?,
//       lastUpdatedDateTime: json['last_updated_date_time'] as String?,
//       insertedIp: json['inserted_ip'] as String?,
//       updatedIp: json['updated_ip'] as String?,
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = {};
//     data['id'] = id;
//     data['added_date_time'] = addedDateTime;
//     data['transaction_date'] = transactionDate;
//     data['financial_year_id'] = financialYearId;
//     data['branch_id'] = branchId;
//     data['state_id'] = stateId;
//     data['district_name'] = districtName;
//     data['active_status'] = activeStatus;
//     data['added_by'] = addedBy;
//     data['added_by_role'] = addedByRole;
//     data['last_updated_by'] = lastUpdatedBy;
//     data['last_updated_by_role'] = lastUpdatedByRole;
//     data['last_updated_date_time'] = lastUpdatedDateTime;
//     data['inserted_ip'] = insertedIp;
//     data['updated_ip'] = updatedIp;
//     return data;
//   }
// }
//
// class Mandal {
//   String? id;
//   String? addedDateTime;
//   String? transactionDate;
//   String? financialYearId;
//   String? branchId;
//   String? stateId;
//   String? districtId;
//   String? mandalName;
//   String? activeStatus;
//   String? addedBy;
//   String? addedByRole;
//   String? lastUpdatedBy;
//   String? lastUpdatedByRole;
//   String? lastUpdatedDateTime;
//   String? insertedIp;
//   String? updatedIp;
//
//   Mandal({
//     this.id,
//     this.addedDateTime,
//     this.transactionDate,
//     this.financialYearId,
//     this.branchId,
//     this.stateId,
//     this.districtId,
//     this.mandalName,
//     this.activeStatus,
//     this.addedBy,
//     this.addedByRole,
//     this.lastUpdatedBy,
//     this.lastUpdatedByRole,
//     this.lastUpdatedDateTime,
//     this.insertedIp,
//     this.updatedIp,
//   });
//
//   factory Mandal.fromJson(Map<String, dynamic> json) {
//     return Mandal(
//       id: json['id'] as String?,
//       addedDateTime: json['added_date_time'] as String?,
//       transactionDate: json['transaction_date'] as String?,
//       financialYearId: json['financial_year_id'] as String?,
//       branchId: json['branch_id'] as String?,
//       stateId: json['state_id'] as String?,
//       districtId: json['district_id'] as String?,
//       mandalName: json['mandal_name'] as String?,
//       activeStatus: json['active_status'] as String?,
//       addedBy: json['added_by'] as String?,
//       addedByRole: json['added_by_role'] as String?,
//       lastUpdatedBy: json['last_updated_by'] as String?,
//       lastUpdatedByRole: json['last_updated_by_role'] as String?,
//       lastUpdatedDateTime: json['last_updated_date_time'] as String?,
//       insertedIp: json['inserted_ip'] as String?,
//       updatedIp: json['updated_ip'] as String?,
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = {};
//     data['id'] = id;
//     data['added_date_time'] = addedDateTime;
//     data['transaction_date'] = transactionDate;
//     data['financial_year_id'] = financialYearId;
//     data['branch_id'] = branchId;
//     data['state_id'] = stateId;
//     data['district_id'] = districtId;
//     data['mandal_name'] = mandalName;
//     data['active_status'] = activeStatus;
//     data['added_by'] = addedBy;
//     data['added_by_role'] = addedByRole;
//     data['last_updated_by'] = lastUpdatedBy;
//     data['last_updated_by_role'] = lastUpdatedByRole;
//     data['last_updated_date_time'] = lastUpdatedDateTime;
//     data['inserted_ip'] = insertedIp;
//     data['updated_ip'] = updatedIp;
//     return data;
//   }
// }
//
// class Village {
//   String? id;
//   String? addedDateTime;
//   String? transactionDate;
//   String? financialYearId;
//   String? branchId;
//   String? stateId;
//   String? districtId;
//   String? mandalId;
//   String? villageName;
//   String? pinCode;
//   String? activeStatus;
//   String? addedBy;
//   String? addedByRole;
//   String? lastUpdatedBy;
//   String? lastUpdatedByRole;
//   String? lastUpdatedDateTime;
//   String? insertedIp;
//   String? updatedIp;
//
//   Village({
//     this.id,
//     this.addedDateTime,
//     this.transactionDate,
//     this.financialYearId,
//     this.branchId,
//     this.stateId,
//     this.districtId,
//     this.mandalId,
//     this.villageName,
//     this.pinCode,
//     this.activeStatus,
//     this.addedBy,
//     this.addedByRole,
//     this.lastUpdatedBy,
//     this.lastUpdatedByRole,
//     this.lastUpdatedDateTime,
//     this.insertedIp,
//     this.updatedIp,
//   });
//
//   factory Village.fromJson(Map<String, dynamic> json) {
//     return Village(
//       id: json['id'] as String?,
//       addedDateTime: json['added_date_time'] as String?,
//       transactionDate: json['transaction_date'] as String?,
//       financialYearId: json['financial_year_id'] as String?,
//       branchId: json['branch_id'] as String?,
//       stateId: json['state_id'] as String?,
//       districtId: json['district_id'] as String?,
//       mandalId: json['mandal_id'] as String?,
//       villageName: json['village_name'] as String?,
//       pinCode: json['pin_code'] as String?,
//       activeStatus: json['active_status'] as String?,
//       addedBy: json['added_by'] as String?,
//       addedByRole: json['added_by_role'] as String?,
//       lastUpdatedBy: json['last_updated_by'] as String?,
//       lastUpdatedByRole: json['last_updated_by_role'] as String?,
//       lastUpdatedDateTime: json['last_updated_date_time'] as String?,
//       insertedIp: json['inserted_ip'] as String?,
//       updatedIp: json['updated_ip'] as String?,
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = {};
//     data['id'] = id;
//     data['added_date_time'] = addedDateTime;
//     data['transaction_date'] = transactionDate;
//     data['financial_year_id'] = financialYearId;
//     data['branch_id'] = branchId;
//     data['state_id'] = stateId;
//     data['district_id'] = districtId;
//     data['mandal_id'] = mandalId;
//     data['village_name'] = villageName;
//     data['pin_code'] = pinCode;
//     data['active_status'] = activeStatus;
//     data['added_by'] = addedBy;
//     data['added_by_role'] = addedByRole;
//     data['last_updated_by'] = lastUpdatedBy;
//     data['last_updated_by_role'] = lastUpdatedByRole;
//     data['last_updated_date_time'] = lastUpdatedDateTime;
//     data['inserted_ip'] = insertedIp;
//     data['updated_ip'] = updatedIp;
//     return data;
//   }
// }
//
//
//
