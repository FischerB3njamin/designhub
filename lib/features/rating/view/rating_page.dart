import 'package:designhub/features/posts/models/post.dart';
import 'package:designhub/features/question/controller/question_controller.dart';
import 'package:designhub/features/question/models/question_katalog.dart';
import 'package:designhub/features/question/models/roll_out_type.dart';
import 'package:designhub/features/rating/widgets/section_rating_overview.dart';
import 'package:designhub/features/rating/widgets/section_rating.dart';
import 'package:designhub/features/rating/widgets/section_rating_footer.dart';
import 'package:flutter/material.dart';

class RatingPage extends StatefulWidget {
  final Post post;
  final RollOutType rolloutType;

  const RatingPage({
    super.key,
    required this.post,
    required this.rolloutType,
  });

  @override
  State<RatingPage> createState() => _RatingPageState();
}

class _RatingPageState extends State<RatingPage> {
  int activeQuestion = 0;
  List<String> answers = [];
  final controller = QuestionController();
  QuestionCatalog? questionKatalog;
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      questionKatalog = await controller.getQuestionCatalog(widget.post.postId);
      setState(() {
        isLoading = false;
        answers = List.generate(questionKatalog!.catalog.length, (index) => '');
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = 'Fehler beim Laden des Fragenkatalogs';
      });
    }
  }

  void addAnswer(int index, answer) => setState(() {
        answers[index - 1] = answer;
        activeQuestion = index;
      });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    if (errorMessage != null) {
      return Center(child: Text(errorMessage!));
    }

    if (questionKatalog == null) {
      return Center(child: Text('Fragenkatalog nicht gefunden'));
    }

    questionKatalog!.catalog = questionKatalog!.catalog
        .where((e) =>
            e.rollOut == widget.rolloutType || e.rollOut == RollOutType.both)
        .toList();

    int numberOfQuestions = questionKatalog!.catalog.length;

    return SizedBox(
      child: ListView(
        physics: NeverScrollableScrollPhysics(),
        children: [
          if (activeQuestion < numberOfQuestions)
            SectionRating(
              callback: addAnswer,
              post: widget.post,
              activeQuestion: activeQuestion,
            ),
          if (activeQuestion == numberOfQuestions)
            SectionRatingOverview(
              questions: questionKatalog!.catalog,
              answers: answers,
              post: widget.post,
              callback: (index) => setState(() => activeQuestion = index),
            ),
          SectionRatingFooter(
            activeQuestion: activeQuestion,
            numberOfQuestions: numberOfQuestions + 1,
          ),
        ],
      ),
    );
  }
}
