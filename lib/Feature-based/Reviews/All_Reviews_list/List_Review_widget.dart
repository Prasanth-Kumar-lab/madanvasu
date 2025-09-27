import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'List_Review_controller.dart';
import 'List_Reviews_model.dart'; // your controller import

class PropertyReviewWidget extends StatefulWidget {
  @override
  _PropertyReviewWidgetState createState() => _PropertyReviewWidgetState();
}

class _PropertyReviewWidgetState extends State<PropertyReviewWidget> {
  final controller = Get.find<PropertyReviewController>();

  late List<bool> isTranslatedList;

  @override
  void initState() {
    super.initState();
    isTranslatedList = List<bool>.filled(
        controller.reviewData.value?.propertyReviews.length ?? 0, false);
  }

  void toggleTranslation(int index) {
    setState(() {
      isTranslatedList[index] = !isTranslatedList[index];
    });
  }

  Future<void> _refreshReviews() async {
    await controller.fetchReviews();
  }


  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      final reviews = controller.reviewData.value?.propertyReviews ?? [];
      final users = controller.reviewData.value?.userDetails ?? [];

      // Ensure isTranslatedList length matches reviews
      if (isTranslatedList.length != reviews.length) {
        isTranslatedList = List<bool>.filled(reviews.length, false);
      }

      return RefreshIndicator(
        onRefresh: _refreshReviews,
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: reviews.length,
          itemBuilder: (context, index) {
            final review = reviews[index];

            final user = users.firstWhere(
                  (u) => u.id == review.userId,
              orElse: () => UserDetail(
                id: '',
                personName: 'Unknown User',
                username: '',
                oldImage: null,
                profileImage: '',
              ),
            );

            final displayText = isTranslatedList[index]
                ? "${review.reviewData} (Translated)"
                : review.reviewData;

            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 16,
                    backgroundColor: Colors.grey.shade300,
                    backgroundImage: user.profileImage.isNotEmpty
                        ? NetworkImage(user.profileImage)
                        : null,
                    child: user.profileImage.isEmpty
                        ? const Icon(Icons.person, color: Colors.white, size: 18)
                        : null,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user.personName,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          displayText,
                          style: const TextStyle(fontSize: 14, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () => toggleTranslation(index),
                    child: Text(
                      isTranslatedList[index] ? "See Original" : "Translate",
                      style: const TextStyle(
                          color: Color(0xFFe57c42), fontSize: 13),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );
    });
  }
}
