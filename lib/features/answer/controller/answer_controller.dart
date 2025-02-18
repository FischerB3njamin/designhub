import 'package:designhub/features/answer/data/answer_mock_db.dart';
import 'package:designhub/features/answer/models/answer.dart';
import 'package:designhub/features/question/models/question_type.dart';

class AnswerController {
  final answerMockDb = AnswerMockDb();

  void addAnswerItem(String postId, String question, String text, String userId,
          QuestionType type) =>
      answerMockDb.addAnswerItem(postId, question, text, userId, type);

  Answer? getAnswer(String postId, String question) =>
      answerMockDb.getAnswer(postId, question);
}
