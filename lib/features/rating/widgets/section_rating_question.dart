import 'package:designhub/features/question/controller/question_controller.dart';
import 'package:designhub/features/question/models/closed_question.dart';
import 'package:designhub/features/posts/models/post.dart';
import 'package:designhub/features/question/models/question.dart';
import 'package:designhub/features/question/models/question_katalog.dart';
import 'package:designhub/features/question/models/question_type.dart';
import 'package:designhub/theme/designhub_colors.dart';
import 'package:flutter/material.dart';

class SectionRatingQuestion extends StatefulWidget {
  const SectionRatingQuestion({
    super.key,
    required this.post,
    required this.activeQuestion,
    required this.callback,
  });
  final Post post;
  final int activeQuestion;
  final Function callback;

  @override
  State<SectionRatingQuestion> createState() => _SectionRatingQuestionState();
}

class _SectionRatingQuestionState extends State<SectionRatingQuestion> {
  String activeState = '';
  TextEditingController answer = TextEditingController();
  final controller = QuestionController();
  QuestionCatalog? questionKatalog;
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      questionKatalog = await controller.getQuestionCatalog(widget.post.postId);
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = 'Fehler beim Laden des Fragenkatalogs';
      });
    }
  }

  List<String> getAnswers() {
    if (questionKatalog == null ||
        questionKatalog!.catalog.length <= widget.activeQuestion) {
      return [];
    }
    return (questionKatalog!.catalog[widget.activeQuestion] as ClosedQuestion)
        .answers;
  }

  @override
  void dispose() {
    answer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    if (errorMessage != null) {
      return Center(child: Text(errorMessage!));
    }

    if (questionKatalog == null ||
        questionKatalog!.catalog.length <= widget.activeQuestion) {
      return Center(child: Text('Frage nicht gefunden'));
    }

    Question question = questionKatalog!.catalog[widget.activeQuestion];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Question ${widget.activeQuestion + 1}",
          style: TextTheme.of(context)
              .headlineMedium!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        Text(question.question),
        if (question.type == QuestionType.open)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: TextFormField(
              controller: answer,
              decoration: InputDecoration(hintText: "Add your Answer!"),
            ),
          ),
        if (question.type == QuestionType.close)
          ...getAnswers().map(
            (e) => GestureDetector(
              onTap: () => setState(() {
                activeState = e;
              }),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    Container(
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                          color: activeState == e
                              ? DesignhubColors.primary
                              : DesignhubColors.transparent,
                          shape: BoxShape.circle,
                          border: Border.all(width: 3)),
                    ),
                    SizedBox(width: 6),
                    Text(e)
                  ],
                ),
              ),
            ),
          ),
        SizedBox(height: 24),
        Container(
          width: double.infinity,
          alignment: Alignment.centerRight,
          child: ElevatedButton(
            onPressed: () {
              String returnedAnswer = question.type == QuestionType.open
                  ? answer.text
                  : activeState;
              widget.callback(widget.activeQuestion + 1, returnedAnswer);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60.0),
              child: Text("Next"),
            ),
          ),
        ),
      ],
    );
  }
}
