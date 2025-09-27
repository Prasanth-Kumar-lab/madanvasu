class PropertyPricePerDay {
  bool? status;
  List<DayChargeData>? data;

  PropertyPricePerDay({this.status, this.data});

  PropertyPricePerDay.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <DayChargeData>[];
      json['data'].forEach((v) {
        data!.add(DayChargeData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonData = <String, dynamic>{};
    jsonData['status'] = status;
    if (data != null) {
      jsonData['data'] = data!.map((v) => v.toJson()).toList();
    }
    return jsonData;
  }
}

class DayChargeData {
  String? id;
  String? forDayCharge;
  String? description;

  DayChargeData({this.id, this.forDayCharge, this.description});

  DayChargeData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    forDayCharge = json['for_day_charge'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonData = <String, dynamic>{};
    jsonData['id'] = id;
    jsonData['for_day_charge'] = forDayCharge;
    jsonData['description'] = description;

    return jsonData;
  }
}



