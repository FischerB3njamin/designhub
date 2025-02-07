import 'package:designhub/features/posts/models/question.dart';
import 'package:designhub/features/posts/view/question_overview.dart';
import 'package:designhub/features/posts/view/question_view.dart';
import 'package:designhub/theme/designhub_colors.dart';
import 'package:flutter/material.dart';

class QuestionSection extends StatefulWidget {
  const QuestionSection({
    super.key,
  });

  @override
  State<QuestionSection> createState() => _QuestionSectionState();
}

class _QuestionSectionState extends State<QuestionSection> {
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
                  builder: (context) => Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    child: FractionallySizedBox(
                      heightFactor: 0.9,
                      child: SingleChildScrollView(child: QuestionView()),
                    ),
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
        ...questions.map((e) => QuestionOverview(question: e)),
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
