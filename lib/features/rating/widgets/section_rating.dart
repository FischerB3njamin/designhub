import 'package:designhub/features/posts/models/post.dart';
import 'package:designhub/features/rating/widgets/section_rating_post_detail.dart';
import 'package:designhub/features/rating/widgets/section_rating_question.dart';
import 'package:flutter/material.dart';

class SectionRating extends StatelessWidget {
  final int activeQuestion;
  final Function callback;
  final Post post;

  const SectionRating({
    super.key,
    required this.callback,
    required this.post,
    required this.activeQuestion,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 50,
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      height: MediaQuery.of(context).size.height * 0.85,
      width: double.infinity,
      child: ListView(
        children: [
          RatingPostDetailSection(post: post),
          SectionRatingQuestion(
            post: post,
            activeQuestion: activeQuestion,
            callback: (index, answer) => callback(index, answer),
          ),
        ],
      ),
    );
  }
}
