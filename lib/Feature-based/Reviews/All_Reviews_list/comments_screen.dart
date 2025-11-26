

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:translator/translator.dart';
import 'package:http/http.dart' as http;

import '../../../utils/shared_pref_helper.dart';
import '../Add_Reviews/Add_Reviews_widget.dart';
import 'List_Reviews_model.dart';
import '../../../app/routes/app_routes.dart';

class CommentsSection extends StatefulWidget {
  final String propertyId;
  const CommentsSection({super.key, required this.propertyId});

  @override
  State<CommentsSection> createState() => _CommentsSectionState();
}

class _CommentsSectionState extends State<CommentsSection> {
  final translator = GoogleTranslator();

  late Future<PropertyReviewResponse> _futureReviews;

  // List to hold comments with translation info
  List<Map<String, dynamic>> _comments = [];

  // To avoid rebuilding comments list multiple times inside build
  bool _commentsPrepared = false;
  String? _userId;


  // @override
  // void initState() {
  //   super.initState();
  //   _futureReviews = fetchPropertyReviews(widget.propertyId);
  // }

  @override
  void initState() {
    super.initState();
    _loadUserId();
    _futureReviews = fetchPropertyReviews(widget.propertyId);
  }

  Future<void> _loadUserId() async {
    final id = await SharedPrefHelper.getUserData('id');
    setState(() {
      _userId = id;
    });
  }


  Future<PropertyReviewResponse> fetchPropertyReviews(String propertyId) async {
    var headers = {
      'Cookie': 'ci_session=a0b0251eb18f24f7b7991eab66c87e7085ee2c66',
    };

    var url = Uri.parse(
      'https://madanvasu.in/new/apis/Api_property_reviews/get_property_reviews?property_id=$propertyId',
    );
    print('Request URL: $url');

    var request = http.Request('GET', url);
    request.headers.addAll(headers);

    final streamedResponse = await request.send();
    print('Response Status Code: ${streamedResponse.statusCode}');

    final jsonString = await streamedResponse.stream.bytesToString();
    print('Response Body: $jsonString');

    if (streamedResponse.statusCode == 200) {
      final Map<String, dynamic> jsonMap = json.decode(jsonString);
      return PropertyReviewResponse.fromJson(jsonMap);
    } else {
      print('Error Response: ${streamedResponse.reasonPhrase}');
      throw Exception('Failed to load data: ${streamedResponse.reasonPhrase}');
    }
  }

  Future<void> _refreshComments() async {
    setState(() {
      _futureReviews = fetchPropertyReviews(widget.propertyId);
      _commentsPrepared = false; // reset so comments list rebuilds on refresh
    });
  }

  void _prepareComments(PropertyReviewResponse response) {
    _comments = response.data.propertyReviews.map((review) {
      final user = response.data.userDetails.firstWhere(
            (u) => u.id == review.userId,
        orElse: () => UserDetail(
          id: review.userId,
          personName: 'Unknown',
          username: '',
          oldImage: null,
          profileImage: '',
        ),
      );
      return {
        "original": review.reviewData,
        "translated": null,
        "isTranslated": false,
        "user": user,
        "date": review.addedDateTime,
      };
    }).toList();
    _commentsPrepared = true;
  }

  void toggleTranslation(int index) async {
    final comment = _comments[index];
    if (!comment['isTranslated']) {
      if (comment['translated'] == null) {
        final translation = await translator.translate(
          comment['original'],
          to: 'en',
        );
        setState(() {
          comment['translated'] = translation.text;
          comment['isTranslated'] = true;
        });
      } else {
        setState(() => comment['isTranslated'] = true);
      }
    } else {
      setState(() => comment['isTranslated'] = false);
    }
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: const Color(0xFFe4b201), width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              Get.toNamed(AppRoutes.ListReview_widget);
            },
            child: ReviewForm(
              propertyId: widget.propertyId,
              userId: _userId ?? '',
            ),
          ),

          const SizedBox(height: 20),
          const Text(
            "Comments & Reviews",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFFe4b201),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: FutureBuilder<PropertyReviewResponse>(
              future: _futureReviews,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  if (!_commentsPrepared) {
                    _prepareComments(snapshot.data!);
                  }
                  return RefreshIndicator(
                    onRefresh: _refreshComments,
                    child: _comments.isEmpty
                        ? ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      children: const [
                        SizedBox(height: 100),
                        Center(child: Text('No comments yet.')),
                      ],
                    )
                        : ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: _comments.length,
                      itemBuilder: (context, index) {
                        final comment = _comments[index];
                        final user = comment['user'] as UserDetail;

                        final displayText = comment['isTranslated'] == true
                            ? comment['translated'] ?? comment['original']
                            : comment['original'];

                        return ListTile(
                          leading: user.profileImage.isNotEmpty
                              ? CircleAvatar(
                            radius: 16,
                            backgroundImage:
                            NetworkImage(user.profileImage),
                          )
                              : const CircleAvatar(
                            radius: 16,
                            backgroundColor: Color(0xFFe57c42),
                            child: Icon(
                              Icons.person,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                          // title: Text(
                          //   user.personName,
                          //   style: const TextStyle(
                          //     fontWeight: FontWeight.bold,
                          //   ),
                          // ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  // Expanded(
                                  //   child: Text(
                                  //     displayText,
                                  //     style: const TextStyle(fontSize: 14, color: Colors.black),
                                  //     overflow: TextOverflow.ellipsis,
                                  //     maxLines: 2,
                                  //   ),
                                  // ),
                                  Expanded(
                                    child: Text(
                                      displayText,
                                      style: const TextStyle(fontSize: 14, color: Colors.black),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () => toggleTranslation(index),
                                    child: Text(
                                      comment['isTranslated'] ? "See Original" : "Translate",
                                      style: const TextStyle(color: Color(0xFFe57c42), fontSize: 13),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                  user.personName,
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.grey),
                              ),
                              Text(
                                comment['date'] ?? '',
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.grey),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return const Center(child: Text('No data.'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}




