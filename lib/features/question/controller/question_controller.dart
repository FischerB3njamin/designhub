import 'package:designhub/features/question/data/question_mock_db.dart';
import 'package:designhub/features/question/models/question.dart';
import 'package:designhub/features/question/models/question_katalog.dart';

class QuestionController {
  final repo = QuestionMockDb();

  QuestionCatalog getQuestionCatalog(postId) => repo.getQuestionCatalog(postId);
  void addQuestionCatalog(String postId, List<Question> catalog) =>
      repo.addQuestionCatalog(postId, catalog);
}
