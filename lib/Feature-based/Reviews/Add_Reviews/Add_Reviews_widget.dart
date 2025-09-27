// import 'package:flutter/material.dart';
// import '../../../data/Api_services/user_api_services.dart';
//
// class ReviewForm extends StatefulWidget {
//   final String propertyId;
//   final String userId;
//
//   const ReviewForm({
//     Key? key,
//     required this.propertyId,
//     required this.userId,
//   }) : super(key: key);
//
//   @override
//   _ReviewFormState createState() => _ReviewFormState();
// }
//
// class _ReviewFormState extends State<ReviewForm> {
//   final TextEditingController _reviewController = TextEditingController();
//   bool _isLoading = false;
//
//   Future<void> _handleSubmitReview() async {
//     final String reviewText = _reviewController.text.trim();
//
//     if (reviewText.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Please enter your comments.')),
//       );
//       return;
//     }
//
//     setState(() => _isLoading = true);
//
//     try {
//       final response = await ApiService.submitReview(
//         reviewText: reviewText,
//         propertyId: widget.propertyId,
//         userId: widget.userId,
//       );
//
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Review submitted successfully!')),
//       );
//       _reviewController.clear();
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error: ${e.toString()}')),
//       );
//     } finally {
//       setState(() => _isLoading = false);
//     }
//   }
//
//   @override
//   void dispose() {
//     _reviewController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         TextField(
//           controller: _reviewController,
//           maxLines: 5,
//           decoration: InputDecoration(
//             labelText: 'Write your comments...',
//             border: OutlineInputBorder(),
//           ),
//         ),
//         SizedBox(height: 20),
//         _isLoading
//             ? Center(child: CircularProgressIndicator())
//             : ElevatedButton(
//           onPressed: _handleSubmitReview,
//           child: Text('Submit Review'),
//         ),
//       ],
//     );
//   }
// }


/////////////////////////



import 'package:flutter/material.dart';
import '../../../data/Api_services/user_api_services.dart';

class ReviewForm extends StatefulWidget {
  final String propertyId;
  final String userId;

  const ReviewForm({
    Key? key,
    required this.propertyId,
    required this.userId,
  }) : super(key: key);

  @override
  _ReviewFormState createState() => _ReviewFormState();
}

class _ReviewFormState extends State<ReviewForm> {
  final TextEditingController _commentController = TextEditingController();
  bool _isLoading = false;

  Future<void> addComment(String reviewText) async {
    reviewText = reviewText.trim();

    if (reviewText.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter your comment.')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final response = await ApiService.submitReview(
        reviewText: reviewText,
        propertyId: widget.propertyId,
        userId: widget.userId,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Review submitted successfully!')),
      );
      _commentController.clear();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Add a Comment",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFFe4b201),
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: _commentController,
          onSubmitted: addComment,
          textInputAction: TextInputAction.done,
          decoration: InputDecoration(
            hintText: " Write your comment...",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Color(0xFFe4b201)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Color(0xFFe4b201), width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            suffixIcon: _isLoading
                ? Padding(
              padding: const EdgeInsets.all(12),
              child: SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Color(0xFFe57c42),
                ),
              ),
            )
                : IconButton(
              icon: const CircleAvatar(
                backgroundColor: Color(0xFFe57c42),
                radius: 15,
                child: Icon(Icons.arrow_upward, size: 18, color: Colors.white),
              ),
              onPressed: () => addComment(_commentController.text),
              tooltip: "Post Comment",
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
