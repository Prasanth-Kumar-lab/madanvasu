class PropertyStatus {
  final bool status;
  final List<PropertyStatusData> data;

  PropertyStatus({
    required this.status,
    required this.data,
  });

  factory PropertyStatus.fromJson(Map<String, dynamic> json) {
    return PropertyStatus(
      status: json['status'],
      data: (json['data'] as List)
          .map((e) => PropertyStatusData.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'status': status,
    'data': data.map((e) => e.toJson()).toList(),
  };
}

class PropertyStatusData {
  final String id;
  final String addedDateTime;
  final String branchId;
  final String financialYearId;
  final String transactionDate;
  final String propertyStatus;
  final String addedBy;
  final String addedByRole;
  final String lastUpdatedDateTime;
  final String lastUpdatedBy;
  final String lastUpdatedByRole;
  final String insertedIp;
  final String updatedIp;

  PropertyStatusData({
    required this.id,
    required this.addedDateTime,
    required this.branchId,
    required this.financialYearId,
    required this.transactionDate,
    required this.propertyStatus,
    required this.addedBy,
    required this.addedByRole,
    required this.lastUpdatedDateTime,
    required this.lastUpdatedBy,
    required this.lastUpdatedByRole,
    required this.insertedIp,
    required this.updatedIp,
  });

  factory PropertyStatusData.fromJson(Map<String, dynamic> json) {
    return PropertyStatusData(
      id: json['id'] ?? '',
      addedDateTime: json['added_date_time'] ?? '',
      branchId: json['branch_id'] ?? '',
      financialYearId: json['financial_year_id'] ?? '',
      transactionDate: json['transaction_date'] ?? '',
      propertyStatus: json['property_status'] ?? '',
      addedBy: json['added_by'] ?? '',
      addedByRole: json['added_by_role'] ?? '',
      lastUpdatedDateTime: json['last_updated_date_time'] ?? '',
      lastUpdatedBy: json['last_updated_by'] ?? '',
      lastUpdatedByRole: json['last_updated_by_role'] ?? '',
      insertedIp: json['inserted_ip'] ?? '',
      updatedIp: json['updated_ip'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'added_date_time': addedDateTime,
    'branch_id': branchId,
    'financial_year_id': financialYearId,
    'transaction_date': transactionDate,
    'property_status': propertyStatus,
    'added_by': addedBy,
    'added_by_role': addedByRole,
    'last_updated_date_time': lastUpdatedDateTime,
    'last_updated_by': lastUpdatedBy,
    'last_updated_by_role': lastUpdatedByRole,
    'inserted_ip': insertedIp,
    'updated_ip': updatedIp,
  };
}
