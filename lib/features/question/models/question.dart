import 'package:designhub/features/question/models/question_type.dart';
import 'package:designhub/features/question/models/roll_out_type.dart';

abstract class Question {
  String question;
  QuestionType type;
  RollOutType rollOut;

  Question(this.question, this.type, this.rollOut);
}
