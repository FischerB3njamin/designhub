import 'package:designhub/features/posts/models/post.dart';
import 'package:designhub/features/rating/widgets/rating_post_detail_section.dart';
import 'package:designhub/features/rating/widgets/rating_question_section.dart';
import 'package:flutter/material.dart';

class RatingScreen extends StatelessWidget {
  const RatingScreen({
    super.key,
    required this.callback,
    required this.post,
    required this.activeQuestion,
  });
  final int activeQuestion;
  final Function callback;
  final Post post;
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
          RatingQuestionSection(
            post: post,
            activeQuestion: activeQuestion,
            callback: (index, answer) => callback(index, answer),
          ),
        ],
      ),
    );
  }
}
