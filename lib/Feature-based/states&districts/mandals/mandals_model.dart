
class MandalNameModel {
  final bool status;
  final List<MandalData> data;

  MandalNameModel({
    required this.status,
    required this.data,
  });

  factory MandalNameModel.fromJson(Map<String, dynamic> json) {
    return MandalNameModel(
      status: json['status'] ?? false,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => MandalData.fromJson(e))
          .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'data': data.map((e) => e.toJson()).toList(),
    };
  }
}

class MandalData {
  final String id;
  final String stateId;
  final String districtId;
  final String mandalName;
  final String activeStatus;

  MandalData({
    required this.id,
    required this.stateId,
    required this.districtId,
    required this.mandalName,
    required this.activeStatus,
  });

  factory MandalData.fromJson(Map<String, dynamic> json) {
    return MandalData(
      id: json['id'] ?? '',
      stateId: json['state_id'] ?? '',
      districtId: json['district_id'] ?? '',
      mandalName: json['mandal_name'] ?? '',
      activeStatus: json['active_status'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'state_id': stateId,
      'district_id': districtId,
      'mandal_name': mandalName,
      'active_status': activeStatus,
    };
  }
}
