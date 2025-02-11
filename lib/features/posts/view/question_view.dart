import 'package:designhub/features/posts/models/closed_question.dart';
import 'package:designhub/features/posts/models/open_question.dart';
import 'package:designhub/features/posts/models/question_type.dart';
import 'package:designhub/features/posts/models/roll_out_type.dart';
import 'package:designhub/features/posts/widgets/closed_question_answer.dart';
import 'package:designhub/features/posts/widgets/segmented_button_question_type.dart';
import 'package:designhub/features/posts/widgets/segmented_button_rollout_type.dart';
import 'package:flutter/material.dart';

class QuestionView extends StatefulWidget {
  const QuestionView({super.key});

  @override
  State<QuestionView> createState() => _QuestionViewState();
}

class _QuestionViewState extends State<QuestionView> {
  QuestionType _selectedQuestionType = QuestionType.open;
  RollOutType _rollOutType = RollOutType.like;
  List<TextEditingController> possibleAnswers = [TextEditingController()];
  TextEditingController questionController = TextEditingController();

  void addItem() {
    if (possibleAnswers.length < 4) {
      setState(() {
        possibleAnswers.add(TextEditingController());
      });
    }
  }

  void removeItem(int index) {
    setState(() {
      possibleAnswers.removeAt(index);
    });
  }

  void returnToOverview(bool isOpen) {
    if (isOpen) {
      Navigator.pop(
        context,
        OpenQuestion(
            questionController.text, _selectedQuestionType, _rollOutType),
      );
    } else {
      List<String> answers = possibleAnswers.map((e) => e.text).toList();
      Navigator.pop(
          context,
          ClosedQuestion(
            questionController.text,
            _selectedQuestionType,
            _rollOutType,
            answers,
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: 750,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Add Questions",
                    style: TextTheme.of(context).headlineLarge,
                  ),
                  IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: Icon(Icons.close))
                ],
              ),
              SizedBox(height: 16),
              TextField(
                controller: questionController,
                decoration: InputDecoration(hintText: "Question"),
              ),
              SizedBox(height: 16),
              Text("When should the question been asked?"),
              SegmentedButtonRolloutType(
                rollOutType: _rollOutType,
                callback: (newSelection) => setState(() {
                  if (newSelection.isNotEmpty) {
                    _rollOutType = newSelection.first;
                  }
                }),
              ),
              SizedBox(height: 16),
              Text("Which kind of question?"),
              SizedBox(height: 2),
              SegmentedButtonQuestionType(
                  callback: (newSelection) => setState(() {
                        if (newSelection.isNotEmpty) {
                          _selectedQuestionType = newSelection.first;
                        }
                      }),
                  selectedQuestionType: _selectedQuestionType),
              SizedBox(height: 24),
              if (_selectedQuestionType == QuestionType.open)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24.0),
                  child: ElevatedButton(
                      onPressed: () => returnToOverview(true),
                      child: Text("Add Question")),
                ),
              if (_selectedQuestionType == QuestionType.close)
                SizedBox(
                  height: 350,
                  child: Column(
                    children: [
                      ...possibleAnswers.map(
                        (e) => ClosedQuestionAnswer(
                            isLast: possibleAnswers.indexOf(e) ==
                                possibleAnswers.length - 1,
                            controller: e,
                            addItem: addItem,
                            removeItem: removeItem,
                            index: possibleAnswers.indexOf(e)),
                      ),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () => returnToOverview(false),
                        child: SizedBox(
                          width: double.infinity,
                          child:
                              Text('Add Question', textAlign: TextAlign.center),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
