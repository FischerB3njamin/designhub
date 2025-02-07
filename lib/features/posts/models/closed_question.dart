import 'package:designhub/features/posts/models/question.dart';

class ClosedQuestion extends Question {
  List<String> answers;

  ClosedQuestion(
    super.question,
    super.type,
    super.rollOut,
    this.answers,
  );
}
