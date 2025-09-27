// class LoginModel {
//   bool status;
//   List<Datum> data;
//
//   LoginModel({
//     required this.status,
//     required this.data,
//   });
//
// }
//
// class Datum {
//   String id;
//   String personName;
//   String email;
//   String mobileNumber;
//   String locationId;
//   String role;
//   String profileImage;
//   String branchId;
//   String financialYearId;
//
//   Datum({
//     required this.id,
//     required this.personName,
//     required this.email,
//     required this.mobileNumber,
//     required this.locationId,
//     required this.role,
//     required this.profileImage,
//     required this.branchId,
//     required this.financialYearId,
//   });
//
// }




class LoginModel {
  final bool status;
  final List<Datum> data;

  LoginModel({required this.status, required this.data});

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      status: json['status'],
      data: List<Datum>.from(json['data'].map((x) => Datum.fromJson(x))),
    );
  }
}

class Datum {
  final String id;
  final String personName;
  final String email;
  final String mobileNumber;
  final String locationId;
  final String role;
  final String profileImage;
  final String branchId;
  final String financialYearId;

  Datum({
    required this.id,
    required this.personName,
    required this.email,
    required this.mobileNumber,
    required this.locationId,
    required this.role,
    required this.profileImage,
    required this.branchId,
    required this.financialYearId,
  });

  factory Datum.fromJson(Map<String, dynamic> json) {
    return Datum(
      id: json['id'],
      personName: json['person_name'],
      email: json['email'],
      mobileNumber: json['mobile_number'],
      locationId: json['location_id'],
      role: json['role'],
      profileImage: json['profile_image'],
      branchId: json['branch_id'],
      financialYearId: json['financial_year_id'],
    );
  }
}
