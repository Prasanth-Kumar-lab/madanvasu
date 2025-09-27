class StatesModel {
  final bool status;
  final List<StatesModelData> data;

  StatesModel({required this.status, required this.data});

  factory StatesModel.fromJson(Map<String, dynamic> json) {
    return StatesModel(
      status: json['status'] ?? false,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => StatesModelData.fromJson(e))
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

class StatesModelData {
  final String id;
  final String stateName;
  final String activeStatus;

  StatesModelData({
    required this.id,
    required this.stateName,
    required this.activeStatus,
  });

  factory StatesModelData.fromJson(Map<String, dynamic> json) {
    return StatesModelData(
      id: json['id'] ?? '',
      stateName: json['state_name'] ?? '',
      activeStatus: json['active_status'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'state_name': stateName,
      'active_status': activeStatus,
    };
  }
}
