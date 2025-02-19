import 'package:designhub/features/posts/models/post.dart';
import 'package:designhub/features/profile/models/profile.dart';
import 'package:designhub/features/question/controller/question_controller.dart';
import 'package:designhub/features/question/models/question_katalog.dart';
import 'package:designhub/features/question/models/question_type.dart';
import 'package:designhub/features/answer/view/answer_page.dart';
import 'package:designhub/gen/assets.gen.dart';
import 'package:designhub/shared/view/custom_bottom_sheet.dart';
import 'package:flutter/material.dart';

class SectionQuestionDetailview extends StatefulWidget {
  final Post post;
  final Profile profile;

  const SectionQuestionDetailview({
    super.key,
    required this.post,
    required this.profile,
  });

  @override
  State<SectionQuestionDetailview> createState() =>
      _SectionQuestionDetailviewState();
}

class _SectionQuestionDetailviewState extends State<SectionQuestionDetailview> {
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
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = 'Fehler beim Laden des Fragenkatalogs';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    if (errorMessage != null) {
      return Center(child: Text(errorMessage!));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 24),
        Text(
          "Questions",
          style: TextTheme.of(context)
              .headlineMedium!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        ...questionKatalog!.catalog.map(
          (e) => GestureDetector(
            onTap: () => CustomBottomSheet.show(
                context,
                AnswerPage(
                    postId: widget.post.postId,
                    question: e.question,
                    profile: widget.profile),
                0.8),
            child: Row(
              children: [
                Expanded(
                  flex: 8,
                  child: Text(
                    e.question,
                    style: TextTheme.of(context).bodyMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                Expanded(
                  child: e.type == QuestionType.open
                      ? Assets.icons.addMessage.svg()
                      : Assets.icons.closed.image(),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 50),
      ],
    );
  }
}
