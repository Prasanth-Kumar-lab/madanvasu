class VillageModel {
  bool status;
  List<Village> data;

  VillageModel({required this.status, required this.data});

  factory VillageModel.fromJson(Map<String, dynamic> json) {
    return VillageModel(
      status: json['status'],
      data: (json['data'] as List).map((item) => Village.fromJson(item)).toList(),
    );
  }
}

class Village {
  String id;
  String villageName;

  Village({required this.id, required this.villageName});

  factory Village.fromJson(Map<String, dynamic> json) {
    return Village(
      id: json['id'],
      villageName: json['village_name'],
    );
  }
}
