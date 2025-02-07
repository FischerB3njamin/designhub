import 'package:designhub/features/posts/models/post.dart';
import 'package:designhub/features/posts/view/new_post_page.dart';
import 'package:designhub/theme/designhub_colors.dart';
import 'package:flutter/material.dart';

class RatingQuestionSection extends StatefulWidget {
  const RatingQuestionSection({
    super.key,
    required this.post,
    required this.activeQuestion,
    required this.callback,
  });
  final Post post;
  final int activeQuestion;
  final Function callback;

  @override
  State<RatingQuestionSection> createState() => _RatingQuestionSectionState();
}

class _RatingQuestionSectionState extends State<RatingQuestionSection> {
  List<String> getAnswers() {
    return (widget.post.questions[widget.activeQuestion] as ClosedQuestion)
        .answers;
  }

  String activeState = '';
  TextEditingController answer = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Question question = widget.post.questions[widget.activeQuestion];
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
              )),
        ),
      ],
    );
  }
}
