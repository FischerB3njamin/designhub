import 'package:designhub/features/question/data/quesion_katalog.mock.dart';
import 'package:designhub/features/question/data/question_repo.dart';
import 'package:designhub/features/question/models/question.dart';
import 'package:designhub/features/question/models/question_katalog.dart';

class QuestionMockDb implements QuestionRepo {
  static final QuestionMockDb _ = QuestionMockDb._internal();
  QuestionMockDb._internal();

  factory QuestionMockDb() => _;

  late List<QuestionCatalog> data = questionKatalog;

  @override
  Future<QuestionCatalog> getQuestionCatalog(postId) async =>
      Future.delayed(Duration(seconds: 1), () {
        return data.where((e) => e.postId == postId).first;
      });

  @override
  Future<void> addQuestionCatalog(
          String postId, List<Question> catalog) async =>
      data.add(QuestionCatalog(postId: postId, catalog: catalog));
}
