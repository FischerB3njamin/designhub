import 'package:designhub/features/answer/models/answer.dart';
import 'package:designhub/features/question/models/question_type.dart';

abstract class AnswerRepo {
  Future<Answer?> getAnswer(String postId, String question);
  Future<void> addAnswerItem(String postId, String question, String text,
      String userId, QuestionType type);
}
