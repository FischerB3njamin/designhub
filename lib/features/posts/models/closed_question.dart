import 'package:designhub/features/posts/models/question.dart';
import 'package:designhub/features/posts/view/new_post_page.dart';

class ClosedQuestion extends Question {
  List<String> answers;

  ClosedQuestion(
    super.question,
    super.type,
    super.rollOut,
    this.answers,
  );
}
