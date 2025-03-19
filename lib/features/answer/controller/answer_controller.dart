import 'package:designhub/features/answer/data/answer_mock_db.dart';
import 'package:designhub/features/answer/models/answer.dart';
import 'package:designhub/features/question/models/question_type.dart';

class AnswerController {
  final repo = AnswerMockDb();

  Future<void> deleteAnswer(postId) => repo.deleteAnswer(postId);
  void addAnswerItem(String postId, String question, String text, String userId,
          QuestionType type) =>
      repo.addAnswerItem(postId, question, text, userId, type);

  Future<Answer?> getAnswer(String postId, String question) =>
      repo.getAnswer(postId, question);
}
