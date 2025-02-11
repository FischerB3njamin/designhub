import 'package:designhub/features/posts/models/post.dart';
import 'package:designhub/features/posts/models/roll_out_type.dart';
import 'package:designhub/features/rating/widgets/section_rating_overview.dart';
import 'package:designhub/features/rating/widgets/section_rating.dart';
import 'package:designhub/features/rating/widgets/section_rating_footer.dart';
import 'package:flutter/material.dart';

class RatingPage extends StatefulWidget {
  final Post post;
  final RollOutType rolloutType;

  const RatingPage({
    super.key,
    required this.post,
    required this.rolloutType,
  });

  @override
  State<RatingPage> createState() => _RatingPageState();
}

class _RatingPageState extends State<RatingPage> {
  int activeQuestion = 0;
  List<String> answers = [];

  void addAnswer(int index, answer) => setState(() {
        answers.add(answer);
        activeQuestion = index;
      });

  @override
  Widget build(BuildContext context) {
    widget.post.questions = widget.post.questions
        .where((e) =>
            e.rollOut == widget.rolloutType || e.rollOut == RollOutType.both)
        .toList();
    int numberOfQuestions = widget.post.questions.length;

    return SizedBox(
      child: ListView(
        physics: NeverScrollableScrollPhysics(),
        children: [
          if (activeQuestion < numberOfQuestions)
            SectionRating(
              callback: addAnswer,
              post: widget.post,
              activeQuestion: activeQuestion,
            ),
          if (activeQuestion == numberOfQuestions)
            SectionRatingOverview(
              questions: widget.post.questions,
              answers: answers,
              post: widget.post,
            ),
          SectionRatingFooter(
            activeQuestion: activeQuestion,
            callback: (int index) => setState(() => activeQuestion = index),
            numberOfQuestions: numberOfQuestions + 1,
          ),
        ],
      ),
    );
  }
}
