import 'package:designhub/features/question/models/question.dart';
import 'package:designhub/features/question/models/question_katalog.dart';

abstract class QuestionRepo {
  Future<QuestionCatalog> getQuestionCatalog(postId);
  Future<void> addQuestionCatalog(String postId, List<Question> catalog);
}
