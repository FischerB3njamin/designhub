import 'package:designhub/features/posts/models/post.dart';
import 'package:designhub/features/question/controller/question_controller.dart';
import 'package:designhub/features/question/models/question_type.dart';
import 'package:designhub/features/answer/view/answer_page.dart';
import 'package:designhub/gen/assets.gen.dart';
import 'package:designhub/shared/view/custom_bottom_sheet.dart';
import 'package:flutter/material.dart';

class SectionQuestionDetailview extends StatelessWidget {
  final Post post;
  final controller = QuestionController();
  late final questionKatalog = controller.getQuestionCatalog(post.postId);

  SectionQuestionDetailview({
    super.key,
    required this.post,
  });

  get postId => null;

  @override
  Widget build(BuildContext context) {
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
        ...questionKatalog.catalog.map(
          (e) => GestureDetector(
            onTap: () => CustomBottomSheet.show(
                context,
                AnswerPage(
                  postId: post.postId,
                  question: e.question,
                ),
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
