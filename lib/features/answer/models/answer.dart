import 'package:designhub/features/answer/models/answer_item.dart';
import 'package:designhub/features/question/models/question_type.dart';

class Answer {
  String postId;
  String question;
  QuestionType type;
  List<AnswerItem> answers;

  Answer({
    required this.postId,
    required this.question,
    required this.type,
    List<AnswerItem>? answers,
  }) : answers = answers ?? [];
}
