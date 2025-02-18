import 'package:designhub/features/question/models/question.dart';

class QuestionCatalog {
  String postId;
  List<Question> catalog;

  QuestionCatalog({required this.postId, required this.catalog});
}
