class VillageModel {
  final bool status;
  final List<VillageData> data;

  VillageModel({
    required this.status,
    required this.data,
  });

  factory VillageModel.fromJson(Map<String, dynamic> json) {
    return VillageModel(
      status: json['status'] ?? false,
      data: (json['data'] as List<dynamic>?)
          ?.map((item) => VillageData.fromJson(item))
          .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'data': data.map((v) => v.toJson()).toList(),
    };
  }
}

class VillageData {
  final String id;
  final String stateId;
  final String districtId;
  final String mandalId;
  final String villageName;
  final String? pinCode;
  final String activeStatus;

  VillageData({
    required this.id,
    required this.stateId,
    required this.districtId,
    required this.mandalId,
    required this.villageName,
    this.pinCode,
    required this.activeStatus,
  });

  factory VillageData.fromJson(Map<String, dynamic> json) {
    return VillageData(
      id: json['id'] ?? '',
      stateId: json['state_id'] ?? '',
      districtId: json['district_id'] ?? '',
      mandalId: json['mandal_id'] ?? '',
      villageName: json['village_name'] ?? '',
      pinCode: json['pin_code'], // Nullable
      activeStatus: json['active_status'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'state_id': stateId,
      'district_id': districtId,
      'mandal_id': mandalId,
      'village_name': villageName,
      'pin_code': pinCode,
      'active_status': activeStatus,
    };
  }
}
