import 'package:designhub/features/answer/data/answer_repo.dart';
import 'package:designhub/features/answer/models/answer.dart';
import 'package:designhub/features/answer/models/answer_item.dart';
import 'package:designhub/features/question/models/question_type.dart';

class AnswerMockDb extends AnswerRepo {
  static final AnswerMockDb _ = AnswerMockDb._internal();
  AnswerMockDb._internal();

  factory AnswerMockDb() => _;

  List<Answer> data = [];

  @override
  void addAnswerItem(String postId, String question, String text, String userId,
      QuestionType type) {
    Answer? answer = getAnswer(postId, question);

    if (answer == null) {
      data.add(Answer(
          postId: postId,
          question: question,
          type: type,
          answers: [AnswerItem(text: text, userId: userId)]));
    } else {
      answer.answers.add(AnswerItem(text: text, userId: userId));
    }
  }

  @override
  Answer? getAnswer(String postId, String question) {
    final result = data
        .where((e) => e.postId == postId && e.question == question)
        .toList();

    return result.isNotEmpty ? result.first : null;
  }
}
