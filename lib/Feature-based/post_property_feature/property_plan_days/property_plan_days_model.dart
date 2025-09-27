class PropertyPlanDays {
  bool? status;
  List<PlanDayData>? data;

  PropertyPlanDays({this.status, this.data});

  PropertyPlanDays.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <PlanDayData>[];
      json['data'].forEach((v) {
        data!.add(PlanDayData.fromJson(v));
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

class PlanDayData {
  String? id;
  String? planDays;
  String? activeStatus;
  String? perDayCharge;
  int? totalPrice;
  String? formattedPrice;
  String? description;

  PlanDayData({
    this.id,
    this.planDays,
    this.activeStatus,
    this.perDayCharge,
    this.totalPrice,
    this.formattedPrice,
    this.description,
  });

  PlanDayData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    planDays = json['plan_days'];
    activeStatus = json['active_status'];
    perDayCharge = json['per_day_charge'];
    totalPrice = json['total_price'];
    formattedPrice = json['formatted_price'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonData = <String, dynamic>{};
    jsonData['id'] = id;
    jsonData['plan_days'] = planDays;
    jsonData['active_status'] = activeStatus;
    jsonData['per_day_charge'] = perDayCharge;
    jsonData['total_price'] = totalPrice;
    jsonData['formatted_price'] = formattedPrice;
    jsonData['description'] = description;
    return jsonData;
  }
}
