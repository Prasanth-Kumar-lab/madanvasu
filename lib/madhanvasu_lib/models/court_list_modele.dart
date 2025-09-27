// class court_list {
//   bool status;
//   List<Data> data;
//
//   court_list({this.status, this.data});
//
//   court_list.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     if (json['data'] != null) {
//       data = new List<Data>();
//       json['data'].forEach((v) {
//         data.add(new Data.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;
//     if (this.data != null) {
//       data['data'] = this.data.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class Data {
//   String id;
//   String addedDateTime;
//   String transactionDate;
//   String financialYearId;
//   String branchId;
//   String courtName;
//   String locationId;
//   String sportsId;
//   String status;
//   String courtDesc;
//   String addedBy;
//   String addedByRole;
//   String courtImage;
//   String insertedIp;
//   String lastUpdatedDateTime;
//   String lastUpdatedBy;
//   String lastUpdatedByRole;
//   String updatedIp;
//   String sportName;
//   String locationName;
//
//   Data(
//       {this.id,
//         this.addedDateTime,
//         this.transactionDate,
//         this.financialYearId,
//         this.branchId,
//         this.courtName,
//         this.locationId,
//         this.sportsId,
//         this.status,
//         this.courtDesc,
//         this.addedBy,
//         this.addedByRole,
//         this.courtImage,
//         this.insertedIp,
//         this.lastUpdatedDateTime,
//         this.lastUpdatedBy,
//         this.lastUpdatedByRole,
//         this.updatedIp,
//         this.sportName,
//         this.locationName});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     addedDateTime = json['added_date_time'];
//     transactionDate = json['transaction_date'];
//     financialYearId = json['financial_year_id'];
//     branchId = json['branch_id'];
//     courtName = json['court_name'];
//     locationId = json['location_id'];
//     sportsId = json['sports_id'];
//     status = json['status'];
//     courtDesc = json['court_desc'];
//     addedBy = json['added_by'];
//     addedByRole = json['added_by_role'];
//     courtImage = json['court_image'];
//     insertedIp = json['inserted_ip'];
//     lastUpdatedDateTime = json['last_updated_date_time'];
//     lastUpdatedBy = json['last_updated_by'];
//     lastUpdatedByRole = json['last_updated_by_role'];
//     updatedIp = json['updated_ip'];
//     sportName = json['sport_name'];
//     locationName = json['location_name'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['added_date_time'] = this.addedDateTime;
//     data['transaction_date'] = this.transactionDate;
//     data['financial_year_id'] = this.financialYearId;
//     data['branch_id'] = this.branchId;
//     data['court_name'] = this.courtName;
//     data['location_id'] = this.locationId;
//     data['sports_id'] = this.sportsId;
//     data['status'] = this.status;
//     data['court_desc'] = this.courtDesc;
//     data['added_by'] = this.addedBy;
//     data['added_by_role'] = this.addedByRole;
//     data['court_image'] = this.courtImage;
//     data['inserted_ip'] = this.insertedIp;
//     data['last_updated_date_time'] = this.lastUpdatedDateTime;
//     data['last_updated_by'] = this.lastUpdatedBy;
//     data['last_updated_by_role'] = this.lastUpdatedByRole;
//     data['updated_ip'] = this.updatedIp;
//     data['sport_name'] = this.sportName;
//     data['location_name'] = this.locationName;
//     return data;
//   }
// }


class CourtList {
  final bool? status;
  final List<CourtData>? data;

  CourtList({this.status, this.data});

  factory CourtList.fromJson(Map<String, dynamic> json) {
    return CourtList(
      status: json['status'],
      data: (json['data'] as List<dynamic>?)
          ?.map((item) => CourtData.fromJson(item))
          .toList(),
    );
  }
}

class CourtData {
  final String? id;
  final String? addedDateTime;
  final String? transactionDate;
  final String? financialYearId;
  final String? branchId;
  final String? courtName;
  final String? locationId;
  final String? sportsId;
  final String? status;
  final String? courtDesc;
  final String? addedBy;
  final String? addedByRole;
  final String? courtImage;
  final String? insertedIp;
  final String? lastUpdatedDateTime;
  final String? lastUpdatedBy;
  final String? lastUpdatedByRole;
  final String? updatedIp;
  final String? sportName;
  final String? locationName;

  CourtData({
    this.id,
    this.addedDateTime,
    this.transactionDate,
    this.financialYearId,
    this.branchId,
    this.courtName,
    this.locationId,
    this.sportsId,
    this.status,
    this.courtDesc,
    this.addedBy,
    this.addedByRole,
    this.courtImage,
    this.insertedIp,
    this.lastUpdatedDateTime,
    this.lastUpdatedBy,
    this.lastUpdatedByRole,
    this.updatedIp,
    this.sportName,
    this.locationName,
  });

  factory CourtData.fromJson(Map<String, dynamic> json) {
    return CourtData(
      id: json['id'],
      addedDateTime: json['added_date_time'],
      transactionDate: json['transaction_date'],
      financialYearId: json['financial_year_id'],
      branchId: json['branch_id'],
      courtName: json['court_name'],
      locationId: json['location_id'],
      sportsId: json['sports_id'],
      status: json['status'],
      courtDesc: json['court_desc'],
      addedBy: json['added_by'],
      addedByRole: json['added_by_role'],
      courtImage: json['court_image'],
      insertedIp: json['inserted_ip'],
      lastUpdatedDateTime: json['last_updated_date_time'],
      lastUpdatedBy: json['last_updated_by'],
      lastUpdatedByRole: json['last_updated_by_role'],
      updatedIp: json['updated_ip'],
      sportName: json['sport_name'],
      locationName: json['location_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'added_date_time': addedDateTime,
      'transaction_date': transactionDate,
      'financial_year_id': financialYearId,
      'branch_id': branchId,
      'court_name': courtName,
      'location_id': locationId,
      'sports_id': sportsId,
      'status': status,
      'court_desc': courtDesc,
      'added_by': addedBy,
      'added_by_role': addedByRole,
      'court_image': courtImage,
      'inserted_ip': insertedIp,
      'last_updated_date_time': lastUpdatedDateTime,
      'last_updated_by': lastUpdatedBy,
      'last_updated_by_role': lastUpdatedByRole,
      'updated_ip': updatedIp,
      'sport_name': sportName,
      'location_name': locationName,
    };
  }
}
