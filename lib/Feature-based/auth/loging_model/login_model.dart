// class LoginModel {
//   final bool status;
//   final List<Datum> data;
//
//   LoginModel({required this.status, required this.data});
//
//   factory LoginModel.fromJson(Map<String, dynamic> json) {
//     return LoginModel(
//       status: json['status'],
//       data: List<Datum>.from(json['data'].map((x) => Datum.fromJson(x))),
//     );
//   }
// }
//
// class Datum {
//   final String id;
//   final String personName;
//   final String email;
//   final String mobileNumber;
//   final String stateId;
//   final String districtId;
//   final String mandalId;
//   final String villageId;
//   final String locationId;
//   final String role;
//   final String profileImage;
//   final String branchId;
//   final String financialYearId;
//
//   Datum({
//     required this.id,
//     required this.personName,
//     required this.email,
//     required this.mobileNumber,
//     required this.stateId,
//     required this.districtId,
//     required this.mandalId,
//     required this.villageId,
//     required this.locationId,
//     required this.role,
//     required this.profileImage,
//     required this.branchId,
//     required this.financialYearId,
//   });
//
//   factory Datum.fromJson(Map<String, dynamic> json) {
//     return Datum(
//       id: json['id'],
//       personName: json['person_name'],
//       email: json['email'],
//       mobileNumber: json['mobile_number'],
//       stateId: json['state_id'],
//       districtId: json['district_id'],
//       mandalId: json['mandal_id'],
//       villageId: json['village_id'],
//       locationId: json['location_id'],
//       role: json['role'],
//       profileImage: json['profile_image'],
//       branchId: json['branch_id'],
//       financialYearId: json['financial_year_id'],
//     );
//   }
// }



///////////

class LoginModel {
  final bool status;
  final String message;
  final List<Datum> data;

  LoginModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      status: json['status'],
      message: json['message'],
      data: List<Datum>.from(json['data'].map((x) => Datum.fromJson(x))),
    );
  }
}

class Datum {
  final String id;
  final String personName;
  final String email;
  final String mobileNumber;
  final String stateId;
  final String districtId;
  final String mandalId;
  final String villageId;
  final String locationId;
  final String role;
  final String profileImage;
  final String branchId;
  final String financialYearId;
  final String stateName;
  final String districtName;
  final String mandalName;
  final String villageName;
  final String areaName;

  Datum({
    required this.id,
    required this.personName,
    required this.email,
    required this.mobileNumber,
    required this.stateId,
    required this.districtId,
    required this.mandalId,
    required this.villageId,
    required this.locationId,
    required this.role,
    required this.profileImage,
    required this.branchId,
    required this.financialYearId,
    required this.stateName,
    required this.districtName,
    required this.mandalName,
    required this.villageName,
    required this.areaName,
  });

  factory Datum.fromJson(Map<String, dynamic> json) {
    return Datum(
      id: json['id'],
      personName: json['person_name'],
      email: json['email'],
      mobileNumber: json['mobile_number'],
      stateId: json['state_id'],
      districtId: json['district_id'],
      mandalId: json['mandal_id'],
      villageId: json['village_id'],
      locationId: json['location_id'],
      role: json['role'],
      profileImage: json['profile_image'],
      branchId: json['branch_id'],
      financialYearId: json['financial_year_id'],
      stateName: json['state_name'],
      districtName: json['district_name'],
      mandalName: json['mandal_name'],
      villageName: json['village_name'],
      areaName: json['area_name'],
    );
  }
}
