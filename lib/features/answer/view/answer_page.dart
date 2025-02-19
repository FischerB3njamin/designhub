import 'package:designhub/features/answer/controller/answer_controller.dart';
import 'package:designhub/features/answer/models/answer.dart';
import 'package:designhub/features/answer/models/answer_item.dart';
import 'package:designhub/features/profile/models/profile.dart';
import 'package:designhub/features/question/models/question_type.dart';
import 'package:designhub/shared/widgets/avatar_circle.dart';
import 'package:designhub/theme/designhub_colors.dart';
import 'package:flutter/material.dart';

class AnswerPage extends StatefulWidget {
  final String postId;
  final String question;
  final Profile profile;

  const AnswerPage({
    super.key,
    required this.postId,
    required this.question,
    required this.profile,
  });

  @override
  State<AnswerPage> createState() => _AnswerPageState();
}

class _AnswerPageState extends State<AnswerPage> {
  final AnswerController controller = AnswerController();

  late final Answer? answer;

  late final List<AnswerItem> items = answer != null ? answer!.answers : [];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: controller.getAnswer(widget.postId, widget.question),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            answer = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  Row(
                    children: [
                      Text(
                        "Question",
                        style: TextTheme.of(context).headlineLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: DesignhubColors.black),
                      ),
                      Spacer(),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(Icons.close),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text(
                    widget.question,
                    style: TextTheme.of(context)
                        .headlineSmall!
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 16),
                  SizedBox(
                    height: 250,
                    width: double.infinity,
                    child: ListView(
                      children: [
                        if (answer != null && answer!.type == QuestionType.open)
                          ...items.map((e) => SectionOpenAnswer(
                              item: e, profile: widget.profile)),
                        if (answer != null &&
                            answer!.type == QuestionType.close)
                          SectionClosedAnswer(
                            items: items,
                            answer: answer!,
                            profile: widget.profile,
                          )
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}

class SectionClosedAnswer extends StatelessWidget {
  final List<AnswerItem> items;
  final Answer answer;
  late Map<String, int> answerWithCounter = {};
  final Profile profile;

  SectionClosedAnswer({
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
    answerWithCounter =
        answerWithCounter.isEmpty ? calculateAnswers() : answerWithCounter;
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

class SectionOpenAnswer extends StatelessWidget {
  final AnswerItem item;
  final Profile profile;

  const SectionOpenAnswer({
    super.key,
    required this.item,
    required this.profile,
  });

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      AvatarCircle(profile: profile, height: 30, width: 30),
      SizedBox(width: 6),
      Text(item.text)
    ]);
  }
}
