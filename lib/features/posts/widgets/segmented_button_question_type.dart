import 'package:designhub/features/posts/models/question_type.dart';
import 'package:flutter/material.dart';

class SegmentedButtonQuestionType extends StatelessWidget {
  final Function callback;
  final QuestionType selectedQuestionType;
  const SegmentedButtonQuestionType({
    super.key,
    required this.callback,
    required this.selectedQuestionType,
  });

  @override
  Widget build(BuildContext context) {
    return SegmentedButton(
      showSelectedIcon: false,
      onSelectionChanged: (newSelection) => callback(newSelection),
      emptySelectionAllowed: true,
      selected: {selectedQuestionType},
      segments: [
        ButtonSegment(
          value: QuestionType.open,
          label: Text("open"),
        ),
        ButtonSegment(
          value: QuestionType.close,
          label: Text("close"),
        ),
      ],
    );
  }
}
