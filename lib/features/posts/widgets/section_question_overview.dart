import 'package:designhub/features/question/models/closed_question.dart';
import 'package:designhub/features/question/models/question.dart';
import 'package:designhub/features/question/models/question_type.dart';
import 'package:designhub/features/question/models/roll_out_type.dart';
import 'package:designhub/gen/assets.gen.dart';
import 'package:designhub/theme/designhub_colors.dart';
import 'package:flutter/material.dart';

class SectionQuestionOverview extends StatelessWidget {
  final Question question;

  const SectionQuestionOverview({
    super.key,
    required this.question,
  });

  Widget getRolloutIcon() {
    switch (question.rollOut) {
      case RollOutType.like:
        return Assets.icons.like.image(width: 25, height: 25);
      case RollOutType.dislike:
        return Assets.icons.dislike.image(width: 25, height: 25);
      case RollOutType.both:
        return SizedBox();
    }
  }

  Widget getQuestionTypeIcon() {
    return question.type == QuestionType.open
        ? Assets.icons.open.image(width: 25, height: 25)
        : Assets.icons.closed.image(width: 30, height: 30);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 14,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
            margin: EdgeInsets.symmetric(vertical: 4),
            decoration: BoxDecoration(
              color: DesignhubColors.grey300,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(question.question),
                if (question.type == QuestionType.close)
                  ...((question as ClosedQuestion)
                      .answers
                      .map((answer) => Row(children: [
                            Text(
                              '\u2022',
                              style: TextStyle(
                                fontSize: 16,
                                height: 1.55,
                              ),
                            ),
                            Text(answer)
                          ]))
                      .toList())
              ],
            ),
          ),
        ),
        Expanded(flex: 2, child: getRolloutIcon()),
        Expanded(flex: 2, child: getQuestionTypeIcon()),
      ],
    );
  }
}
