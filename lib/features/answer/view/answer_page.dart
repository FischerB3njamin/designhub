import 'package:designhub/features/answer/controller/answer_controller.dart';
import 'package:designhub/features/answer/models/answer.dart';
import 'package:designhub/features/answer/models/answer_item.dart';
import 'package:designhub/features/answer/widgets/section_closed_answer.dart';
import 'package:designhub/features/answer/widgets/section_open_answer.dart';
import 'package:designhub/features/profile/models/profile.dart';
import 'package:designhub/features/question/models/question_type.dart';
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
  bool isLoading = true;
  Answer? answer;

  late final List<AnswerItem> items = answer != null ? answer!.answers : [];

  @override
  void initState() {
    _loading();
    super.initState();
  }

  void _loading() async {
    final result = await controller.getAnswer(widget.postId, widget.question);
    if (result != null) answer = result;

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          Row(
            children: [
              Text(
                "Question",
                style: TextTheme.of(context).headlineLarge!.copyWith(
                    fontWeight: FontWeight.bold, color: DesignhubColors.black),
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
                  ...items.map((e) =>
                      SectionOpenAnswer(item: e, profile: widget.profile)),
                if (answer != null && answer!.type == QuestionType.close)
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
}
