class SportName {
  final bool? status;
  final List<SportData>? data;

  SportName({this.status, this.data});

  factory SportName.fromJson(Map<String, dynamic> json) {
    return SportName(
      status: json['status'] as bool?,
      data: (json['data'] as List<dynamic>?)
          ?.map((item) => SportData.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'data': data?.map((sport) => sport.toJson()).toList(),
    };
  }
}

class SportData {
  final String? id;
  final String? addedDateTime;
  final String? financialYearId;
  final String? branchId;
  final String? sportName;
  final String? sportImage;
  final String? oldImage;
  final String? activeStatus;
  final String? sportDesc;
  final String? addedBy;
  final String? addedByRole;
  final String? insertedIp;
  final String? lastUpdatedDateTime;
  final String? lastUpdatedBy;
  final String? lastUpdatedByRole;
  final String? updatedIp;

  SportData({
    this.id,
    this.addedDateTime,
    this.financialYearId,
    this.branchId,
    this.sportName,
    this.sportImage,
    this.oldImage,
    this.activeStatus,
    this.sportDesc,
    this.addedBy,
    this.addedByRole,
    this.insertedIp,
    this.lastUpdatedDateTime,
    this.lastUpdatedBy,
    this.lastUpdatedByRole,
    this.updatedIp,
  });

  factory SportData.fromJson(Map<String, dynamic> json) {
    return SportData(
      id: json['id'] as String?,
      addedDateTime: json['added_date_time'] as String?,
      financialYearId: json['financial_year_id'] as String?,
      branchId: json['branch_id'] as String?,
      sportName: json['sport_name'] as String?,
      sportImage: json['sport_image'] as String?,
      oldImage: json['old_image'] as String?,
      activeStatus: json['active_status'] as String?,
      sportDesc: json['sport_desc'] as String?,
      addedBy: json['added_by'] as String?,
      addedByRole: json['added_by_role'] as String?,
      insertedIp: json['inserted_ip'] as String?,
      lastUpdatedDateTime: json['last_updated_date_time'] as String?,
      lastUpdatedBy: json['last_updated_by'] as String?,
      lastUpdatedByRole: json['last_updated_by_role'] as String?,
      updatedIp: json['updated_ip'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'added_date_time': addedDateTime,
      'financial_year_id': financialYearId,
      'branch_id': branchId,
      'sport_name': sportName,
      'sport_image': sportImage,
      'old_image': oldImage,
      'active_status': activeStatus,
      'sport_desc': sportDesc,
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
