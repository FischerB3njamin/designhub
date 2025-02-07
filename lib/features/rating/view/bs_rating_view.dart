import 'package:designhub/features/posts/models/post.dart';
import 'package:designhub/features/posts/view/new_post_page.dart';
import 'package:designhub/features/rating/view/rating_overview_screen.dart';
import 'package:designhub/features/rating/view/rating_screen.dart';
import 'package:designhub/features/rating/widgets/rating_footer_section.dart';
import 'package:flutter/material.dart';

class BsRatingView extends StatefulWidget {
  final Post post;
  final RollOutType rolloutType;

  const BsRatingView({
    super.key,
    required this.post,
    required this.rolloutType,
  });

  @override
  State<BsRatingView> createState() => _BsRatingViewState();
}

class _BsRatingViewState extends State<BsRatingView> {
  int activeQuestion = 0;
  List<String> answers = [];

  @override
  Widget build(BuildContext context) {
    int numberOfQuestions = widget.post.questions.length;
    widget.post.questions = widget.post.questions
        .where((e) =>
            e.rollOut == widget.rolloutType || e.rollOut == RollOutType.both)
        .toList();

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(24)),
        padding: EdgeInsets.only(
          top: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: FractionallySizedBox(
          heightFactor: 1,
          child: SizedBox(
            child: ListView(
              physics: NeverScrollableScrollPhysics(),
              children: [
                if (activeQuestion < numberOfQuestions)
                  RatingScreen(
                      callback: (int index, answer) => setState(() {
                            answers.add(answer);
                            activeQuestion = index;
                          }),
                      post: widget.post,
                      activeQuestion: activeQuestion),
                if (activeQuestion == numberOfQuestions)
                  RatingOverviewScreen(
                    questions: widget.post.questions,
                    answers: answers,
                    post: widget.post,
                  ),
                RatingFooterSection(
                    activeQuestion: activeQuestion,
                    callback: (int index) {
                      setState(() {
                        activeQuestion = index;
                      });
                    },
                    numberOfQuestions: numberOfQuestions + 1),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
