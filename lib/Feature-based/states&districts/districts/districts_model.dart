
class DistrictNameModel {
  final bool status;
  final List<DistrictData> data;

  DistrictNameModel({
    required this.status,
    required this.data,
  });

  factory DistrictNameModel.fromJson(Map<String, dynamic> json) {
    return DistrictNameModel(
      status: json['status'] ?? false,
      data: (json['data'] as List<dynamic>?)
          ?.map((item) => DistrictData.fromJson(item))
          .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'data': data.map((d) => d.toJson()).toList(),
    };
  }
}

class DistrictData {
  final String id;
  final String stateId;
  final String districtName;
  final String activeStatus;

  DistrictData({
    required this.id,
    required this.stateId,
    required this.districtName,
    required this.activeStatus,
  });

  factory DistrictData.fromJson(Map<String, dynamic> json) {
    return DistrictData(
      id: json['id'] ?? '',
      stateId: json['state_id'] ?? '',
      districtName: json['district_name'] ?? '',
      activeStatus: json['active_status'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'state_id': stateId,
      'district_name': districtName,
      'active_status': activeStatus,
    };
  }
}
