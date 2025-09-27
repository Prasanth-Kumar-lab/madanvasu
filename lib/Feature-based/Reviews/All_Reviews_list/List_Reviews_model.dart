class PropertyReviewResponse {
  final bool status;
  final ReviewData data;

  PropertyReviewResponse({required this.status, required this.data});

  factory PropertyReviewResponse.fromJson(Map<String, dynamic> json) {
    return PropertyReviewResponse(
      status: json['status'],
      data: ReviewData.fromJson(json['data']),
    );
  }
}

class ReviewData {
  final List<PropertyReview> propertyReviews;
  final List<UserDetail> userDetails;

  ReviewData({required this.propertyReviews, required this.userDetails});

  factory ReviewData.fromJson(Map<String, dynamic> json) {
    return ReviewData(
      propertyReviews: (json['property_reviews_data'] as List)
          .map((e) => PropertyReview.fromJson(e))
          .toList(),
      userDetails: (json['user_details'] as List)
          .map((e) => UserDetail.fromJson(e))
          .toList(),
    );
  }
}

class PropertyReview {
  final String id;
  final String propertyId;
  final String userId;
  final String reviewData;
  final String addedDateTime;
  final String transactionDate;

  PropertyReview({
    required this.id,
    required this.propertyId,
    required this.userId,
    required this.reviewData,
    required this.addedDateTime,
    required this.transactionDate,
  });

  factory PropertyReview.fromJson(Map<String, dynamic> json) {
    return PropertyReview(
      id: json['id'],
      propertyId: json['property_id'],
      userId: json['user_id'],
      reviewData: json['review_data'],
      addedDateTime: json['added_date_time'],
      transactionDate: json['transaction_date'],
    );
  }
}

class UserDetail {
  final String id;
  final String personName;
  final String username;
  final String? oldImage;
  final String profileImage;

  UserDetail({
    required this.id,
    required this.personName,
    required this.username,
    this.oldImage,
    required this.profileImage,
  });

  factory UserDetail.fromJson(Map<String, dynamic> json) {
    return UserDetail(
      id: json['id'],
      personName: json['person_name'],
      username: json['username'],
      oldImage: json['old_image'],
      profileImage: json['profile_image'],
    );
  }
}
