class NotificationList {
  final bool? status;
  final NotificationData? data;

  NotificationList({this.status, this.data});

  factory NotificationList.fromJson(Map<String, dynamic> json) {
    return NotificationList(
      status: json['status'] as bool?,
      data: json['data'] != null
          ? NotificationData.fromJson(json['data'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      if (data != null) 'data': data!.toJson(),
    };
  }
}

class NotificationData {
  final List<ExpiryNotification>? expiryNotifications;
  final List<UserDetail>? users;

  NotificationData({this.expiryNotifications, this.users});

  factory NotificationData.fromJson(Map<String, dynamic> json) {
    return NotificationData(
      expiryNotifications: (json['expiry_notifications_data'] as List?)
          ?.map((e) => ExpiryNotification.fromJson(e))
          .toList(),
      users: (json['user_details'] as List?)
          ?.map((e) => UserDetail.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (expiryNotifications != null)
        'expiry_notifications_data':
        expiryNotifications!.map((e) => e.toJson()).toList(),
      if (users != null)
        'user_details': users!.map((e) => e.toJson()).toList(),
    };
  }
}

class ExpiryNotification {
  final String? id;
  final String? userId;
  final String? propertyId;
  final String? expiryDate;
  final String? message;
  final String? addedDateTime;
  final String? transactionDate;

  ExpiryNotification({
    this.id,
    this.userId,
    this.propertyId,
    this.expiryDate,
    this.message,
    this.addedDateTime,
    this.transactionDate,
  });

  factory ExpiryNotification.fromJson(Map<String, dynamic> json) {
    return ExpiryNotification(
      id: json['id'] as String?,
      userId: json['user_id'] as String?,
      propertyId: json['property_id'] as String?,
      expiryDate: json['expiry_date'] as String?,
      message: json['message'] as String?,
      addedDateTime: json['added_date_time'] as String?,
      transactionDate: json['transaction_date'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'property_id': propertyId,
      'expiry_date': expiryDate,
      'message': message,
      'added_date_time': addedDateTime,
      'transaction_date': transactionDate,
    };
  }
}

class UserDetail {
  final String? id;
  final String? personName;
  final String? username;
  final String? oldImage;
  final String? profileImage;

  UserDetail({
    this.id,
    this.personName,
    this.username,
    this.oldImage,
    this.profileImage,
  });

  factory UserDetail.fromJson(Map<String, dynamic> json) {
    return UserDetail(
      id: json['id'] as String?,
      personName: json['person_name'] as String?,
      username: json['username'] as String?,
      oldImage: json['old_image'] as String?,
      profileImage: json['profile_image'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'person_name': personName,
      'username': username,
      'old_image': oldImage,
      'profile_image': profileImage,
    };
  }
}
