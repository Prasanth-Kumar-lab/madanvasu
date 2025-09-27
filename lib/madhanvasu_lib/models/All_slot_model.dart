// class AllSlotModels {
//   final bool? status;
//   final List<SlotData>? data;
//
//   AllSlotModels({this.status, this.data});
//
//   factory AllSlotModels.fromJson(Map<String, dynamic> json) {
//     return AllSlotModels(
//       status: json['status'],
//       data: (json['data'] as List?)?.map((e) => SlotData.fromJson(e)).toList(),
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'status': status,
//       'data': data?.map((e) => e.toJson()).toList(),
//     };
//   }
// }
//
// class SlotData {
//   final String? id;
//   final String? addedDateTime;
//   final String? transactionDate;
//   final String? financialYearId;
//   final String? branchId;
//   final String? sportsId;
//   final String? courtId;
//   final String? slotFromTime;
//   final String? slotToTime;
//   final String? peakHour;
//   final List<Tariff>? tariff;
//   final String? activeStatus;
//   final String? addedBy;
//   final String? addedByRole;
//   final String? insertedIp;
//   final String? lastUpdatedBy;
//   final String? lastUpdatedByRole;
//   final String? lastUpdatedDateTime;
//   final String? updatedIp;
//   final List<CourtName>? courtName;
//
//   SlotData({
//     this.id,
//     this.addedDateTime,
//     this.transactionDate,
//     this.financialYearId,
//     this.branchId,
//     this.sportsId,
//     this.courtId,
//     this.slotFromTime,
//     this.slotToTime,
//     this.peakHour,
//     this.tariff,
//     this.activeStatus,
//     this.addedBy,
//     this.addedByRole,
//     this.insertedIp,
//     this.lastUpdatedBy,
//     this.lastUpdatedByRole,
//     this.lastUpdatedDateTime,
//     this.updatedIp,
//     this.courtName,
//   });
//
//   factory SlotData.fromJson(Map<String, dynamic> json) {
//     return SlotData(
//       id: json['id'],
//       addedDateTime: json['added_date_time'],
//       transactionDate: json['transaction_date'],
//       financialYearId: json['financial_year_id'],
//       branchId: json['branch_id'],
//       sportsId: json['sports_id'],
//       courtId: json['court_id'],
//       slotFromTime: json['slot_from_time'],
//       slotToTime: json['slot_to_time'],
//       peakHour: json['peak_hour'],
//       tariff: (json['tariff'] as List?)?.map((e) => Tariff.fromJson(e)).toList(),
//       activeStatus: json['active_status'],
//       addedBy: json['added_by'],
//       addedByRole: json['added_by_role'],
//       insertedIp: json['inserted_ip'],
//       lastUpdatedBy: json['last_updated_by'],
//       lastUpdatedByRole: json['last_updated_by_role'],
//       lastUpdatedDateTime: json['last_updated_date_time'],
//       updatedIp: json['updated_ip'],
//       courtName: (json['court_name'] as List?)?.map((e) => CourtName.fromJson(e)).toList(),
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'added_date_time': addedDateTime,
//       'transaction_date': transactionDate,
//       'financial_year_id': financialYearId,
//       'branch_id': branchId,
//       'sports_id': sportsId,
//       'court_id': courtId,
//       'slot_from_time': slotFromTime,
//       'slot_to_time': slotToTime,
//       'peak_hour': peakHour,
//       'tariff': tariff?.map((e) => e.toJson()).toList(),
//       'active_status': activeStatus,
//       'added_by': addedBy,
//       'added_by_role': addedByRole,
//       'inserted_ip': insertedIp,
//       'last_updated_by': lastUpdatedBy,
//       'last_updated_by_role': lastUpdatedByRole,
//       'last_updated_date_time': lastUpdatedDateTime,
//       'updated_ip': updatedIp,
//       'court_name': courtName?.map((e) => e.toJson()).toList(),
//     };
//   }
// }
//
// class Tariff {
//   final String? id;
//   final String? tariff;
//
//   Tariff({this.id, this.tariff});
//
//   factory Tariff.fromJson(Map<String, dynamic> json) {
//     return Tariff(
//       id: json['id'],
//       tariff: json['tariff'],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'tariff': tariff,
//     };
//   }
// }
//
// class CourtName {
//   final String? id;
//   final String? courtName;
//   final bool? available;
//
//   CourtName({this.id, this.courtName,this.available});
//
//   factory CourtName.fromJson(Map<String, dynamic> json) {
//     return CourtName(
//       id: json['id'],
//       courtName: json['court_name'],
//       available: json['available'],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'court_name': courtName,
//     };
//   }
// }


//////////////


class AllSlotModels {
  final bool? status;
  final List<SlotData>? data;

  AllSlotModels({this.status, this.data});

  factory AllSlotModels.fromJson(Map<String, dynamic> json) {
    return AllSlotModels(
      status: json['status'],
      data: (json['data'] as List?)?.map((e) => SlotData.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'data': data?.map((e) => e.toJson()).toList(),
    };
  }
}

class SlotData {
  final String? id;
  final String? addedDateTime;
  final String? transactionDate;
  final String? financialYearId;
  final String? branchId;
  final String? sportsId;
  final String? courtId;
  final String? slotFromTime;
  final String? slotToTime;
  final String? peakHour;
  final List<Tariff>? tariff;
  final String? activeStatus;
  final String? addedBy;
  final String? addedByRole;
  final String? insertedIp;
  final String? lastUpdatedBy;
  final String? lastUpdatedByRole;
  final String? lastUpdatedDateTime;
  final String? updatedIp;
  final List<CourtName>? courtName;
  final List<BookingStatus>? bookingStatus;

  SlotData({
    this.id,
    this.addedDateTime,
    this.transactionDate,
    this.financialYearId,
    this.branchId,
    this.sportsId,
    this.courtId,
    this.slotFromTime,
    this.slotToTime,
    this.peakHour,
    this.tariff,
    this.activeStatus,
    this.addedBy,
    this.addedByRole,
    this.insertedIp,
    this.lastUpdatedBy,
    this.lastUpdatedByRole,
    this.lastUpdatedDateTime,
    this.updatedIp,
    this.courtName,
    this.bookingStatus,
  });

  factory SlotData.fromJson(Map<String, dynamic> json) {
    return SlotData(
      id: json['id'],
      addedDateTime: json['added_date_time'],
      transactionDate: json['transaction_date'],
      financialYearId: json['financial_year_id'],
      branchId: json['branch_id'],
      sportsId: json['sports_id'],
      courtId: json['court_id'],
      slotFromTime: json['slot_from_time'],
      slotToTime: json['slot_to_time'],
      peakHour: json['peak_hour'],
      tariff: (json['tariff'] as List?)?.map((e) => Tariff.fromJson(e)).toList(),
      activeStatus: json['active_status'],
      addedBy: json['added_by'],
      addedByRole: json['added_by_role'],
      insertedIp: json['inserted_ip'],
      lastUpdatedBy: json['last_updated_by'],
      lastUpdatedByRole: json['last_updated_by_role'],
      lastUpdatedDateTime: json['last_updated_date_time'],
      updatedIp: json['updated_ip'],
      courtName: (json['court_name'] as List?)?.map((e) => CourtName.fromJson(e)).toList(),
      bookingStatus: (json['booking_status'] as List?)?.map((e) => BookingStatus.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'added_date_time': addedDateTime,
      'transaction_date': transactionDate,
      'financial_year_id': financialYearId,
      'branch_id': branchId,
      'sports_id': sportsId,
      'court_id': courtId,
      'slot_from_time': slotFromTime,
      'slot_to_time': slotToTime,
      'peak_hour': peakHour,
      'tariff': tariff?.map((e) => e.toJson()).toList(),
      'active_status': activeStatus,
      'added_by': addedBy,
      'added_by_role': addedByRole,
      'inserted_ip': insertedIp,
      'last_updated_by': lastUpdatedBy,
      'last_updated_by_role': lastUpdatedByRole,
      'last_updated_date_time': lastUpdatedDateTime,
      'updated_ip': updatedIp,
      'court_name': courtName?.map((e) => e.toJson()).toList(),
      'booking_status': bookingStatus?.map((e) => e.toJson()).toList(),
    };
  }
}

class Tariff {
  final String? id;
  final String? tariff;

  Tariff({this.id, this.tariff});

  factory Tariff.fromJson(Map<String, dynamic> json) {
    return Tariff(
      id: json['id'],
      tariff: json['tariff'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tariff': tariff,
    };
  }
}

class CourtName {
  final String? id;
  final String? courtName;
  final bool? available;

  CourtName({this.id, this.courtName, this.available});

  factory CourtName.fromJson(Map<String, dynamic> json) {
    return CourtName(
      id: json['id'],
      courtName: json['court_name'],
      available: json['available'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'court_name': courtName,
      // Include only if needed
      if (available != null) 'available': available,
    };
  }
}

class BookingStatus {
  final String? id;
  final String? slotId;
  final String? playingDate;
  final String? bookingStatus;

  BookingStatus({
    this.id,
    this.slotId,
    this.playingDate,
    this.bookingStatus,
  });

  factory BookingStatus.fromJson(Map<String, dynamic> json) {
    return BookingStatus(
      id: json['id'],
      slotId: json['slot_id'],
      playingDate: json['playing_date'],
      bookingStatus: json['booking_status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'slot_id': slotId,
      'playing_date': playingDate,
      'booking_status': bookingStatus,
    };
  }
}

