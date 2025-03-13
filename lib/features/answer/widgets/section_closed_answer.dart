import 'package:designhub/features/answer/models/answer.dart';
import 'package:designhub/features/answer/models/answer_item.dart';
import 'package:designhub/features/profile/models/profile.dart';
import 'package:flutter/material.dart';

class SectionClosedAnswer extends StatelessWidget {
  final List<AnswerItem> items;
  final Answer answer;
  final Profile profile;

  const SectionClosedAnswer({
    super.key,
    required this.items,
    required this.answer,
    required this.profile,
  });

  Map<String, int> calculateAnswers() {
    Map<String, int> answerWithCounter = {};

    for (final item in items) {
      answerWithCounter[item.text] = (answerWithCounter[item.text] ?? 0) + 1;
    }

    return answerWithCounter;
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, int> answerWithCounter = calculateAnswers();

    return Column(
      children: [
        for (final key in answerWithCounter.keys)
          Container(
            padding: EdgeInsets.all(8),
            child: Row(
              children: [
                Container(
                  height: 25,
                  width: 25,
                  decoration: BoxDecoration(
                    border: Border.all(width: 4),
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(
                  width: 6,
                ),
                Text(
                  key,
                  style: TextTheme.of(context).bodyLarge,
                ),
                Spacer(),
                Text(
                  answerWithCounter[key].toString(),
                  style: TextTheme.of(context)
                      .bodyLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          )
      ],
    );
  }
}
