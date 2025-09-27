class BookingHistory {
  bool status;
  Data data;

  BookingHistory({required this.status, required this.data});

  factory BookingHistory.fromJson(Map<String, dynamic> json) {
    return BookingHistory(
      status: json['status'],
      data: Data.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'data': data.toJson(),
    };
  }
}

class Data {
  List<BookingData> bookingData;
  List<List> sportsData;
  List<List> courtData;

  Data({required this.bookingData, required this.sportsData, required this.courtData});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      bookingData: (json['booking_data'] as List)
          .map((item) => BookingData.fromJson(item))
          .toList(),
      sportsData: List<List>.from(json['sports_data']),
      courtData: List<List>.from(json['court_data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'booking_data': bookingData.map((e) => e.toJson()).toList(),
      'sports_data': sportsData,
      'court_data': courtData,
    };
  }
}

class BookingData {
  String id;
  String addedDateTime;
  String transactionDate;
  String branchId;
  String financialYearId;
  String bookingNumber;
  String bookingType;
  String userId;
  String courtId;
  String sportId;
  String slotId;
  String datesSelected;
  String noOfSlots;
  String price;
  String total;
  String termsConditions;
  String bookingStatus;
  String addedBy;
  String addedByRole;
  String lastUpdatedBy;
  String lastUpdatedByRole;
  String lastUpdatedDateTime;
  String updatedIp;
  String insertedIp;

  BookingData({
    required this.id,
    required this.addedDateTime,
    required this.transactionDate,
    required this.branchId,
    required this.financialYearId,
    required this.bookingNumber,
    required this.bookingType,
    required this.userId,
    required this.courtId,
    required this.sportId,
    required this.slotId,
    required this.datesSelected,
    required this.noOfSlots,
    required this.price,
    required this.total,
    required this.termsConditions,
    required this.bookingStatus,
    required this.addedBy,
    required this.addedByRole,
    required this.lastUpdatedBy,
    required this.lastUpdatedByRole,
    required this.lastUpdatedDateTime,
    required this.updatedIp,
    required this.insertedIp,
  });

  factory BookingData.fromJson(Map<String, dynamic> json) {
    return BookingData(
      id: json['id'],
      addedDateTime: json['added_date_time'],
      transactionDate: json['transaction_date'],
      branchId: json['branch_id'],
      financialYearId: json['financial_year_id'],
      bookingNumber: json['booking_number'],
      bookingType: json['booking_type'],
      userId: json['user_id'],
      courtId: json['court_id'],
      sportId: json['sport_id'],
      slotId: json['slot_id'],
      datesSelected: json['dates_selected'],
      noOfSlots: json['no_of_slots'],
      price: json['price'],
      total: json['total'],
      termsConditions: json['terms_conditions'],
      bookingStatus: json['booking_status'],
      addedBy: json['added_by'],
      addedByRole: json['added_by_role'],
      lastUpdatedBy: json['last_updated_by'],
      lastUpdatedByRole: json['last_updated_by_role'],
      lastUpdatedDateTime: json['last_updated_date_time'],
      updatedIp: json['updated_ip'],
      insertedIp: json['inserted_ip'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'added_date_time': addedDateTime,
      'transaction_date': transactionDate,
      'branch_id': branchId,
      'financial_year_id': financialYearId,
      'booking_number': bookingNumber,
      'booking_type': bookingType,
      'user_id': userId,
      'court_id': courtId,
      'sport_id': sportId,
      'slot_id': slotId,
      'dates_selected': datesSelected,
      'no_of_slots': noOfSlots,
      'price': price,
      'total': total,
      'terms_conditions': termsConditions,
      'booking_status': bookingStatus,
      'added_by': addedBy,
      'added_by_role': addedByRole,
      'last_updated_by': lastUpdatedBy,
      'last_updated_by_role': lastUpdatedByRole,
      'last_updated_date_time': lastUpdatedDateTime,
      'updated_ip': updatedIp,
      'inserted_ip': insertedIp,
    };
  }
}
