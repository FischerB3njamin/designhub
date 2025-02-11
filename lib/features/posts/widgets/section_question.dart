import 'package:designhub/features/posts/models/question.dart';
import 'package:designhub/features/posts/widgets/section_question_overview.dart';
import 'package:designhub/features/posts/view/question_view.dart';
import 'package:designhub/shared/view/custom_bottom_sheet.dart';
import 'package:designhub/theme/designhub_colors.dart';
import 'package:flutter/material.dart';

class SectionQuestion extends StatefulWidget {
  const SectionQuestion({
    super.key,
  });

  @override
  State<SectionQuestion> createState() => _SectionQuestionState();
}

class _SectionQuestionState extends State<SectionQuestion> {
  List<Question> questions = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Add Questions",
              style: TextTheme.of(context).headlineLarge,
            ),
            IconButton(
              color: DesignhubColors.white,
              style: ButtonStyle(
                backgroundColor:
                    WidgetStateProperty.all(DesignhubColors.primary),
              ),
              onPressed: () async {
                Question? question = await showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) => CustomBottomSheet(
                    widget: QuestionView(),
                    height: 0.9,
                  ),
                );
                if (question != null) {
                  setState(() {
                    questions.add(question);
                  });
                }
              },
              icon: Icon(
                Icons.add,
                size: 28,
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        ...questions.map((e) => SectionQuestionOverview(question: e)),
        SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {},
          child: SizedBox(
            width: double.infinity,
            child: Text(
              "create Post",
              textAlign: TextAlign.center,
            ),
          ),
        )
      ],
    );
  }
}
