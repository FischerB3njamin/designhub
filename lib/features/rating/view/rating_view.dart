import 'package:designhub/features/posts/models/post.dart';
import 'package:designhub/features/posts/models/roll_out_type.dart';
import 'package:designhub/features/rating/view/rating_overview_screen.dart';
import 'package:designhub/features/rating/view/rating_screen.dart';
import 'package:designhub/features/rating/widgets/rating_footer_section.dart';
import 'package:flutter/material.dart';

class RatingView extends StatefulWidget {
  final Post post;
  final RollOutType rolloutType;

  const RatingView({
    super.key,
    required this.post,
    required this.rolloutType,
  });

  @override
  State<RatingView> createState() => _RatingViewState();
}

class _RatingViewState extends State<RatingView> {
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
            RatingScreen(
              callback: addAnswer,
              post: widget.post,
              activeQuestion: activeQuestion,
            ),
          if (activeQuestion == numberOfQuestions)
            RatingOverviewScreen(
              questions: widget.post.questions,
              answers: answers,
              post: widget.post,
            ),
          RatingFooterSection(
            activeQuestion: activeQuestion,
            callback: (int index) => setState(() => activeQuestion = index),
            numberOfQuestions: numberOfQuestions + 1,
          ),
        ],
      ),
    );
  }
}
