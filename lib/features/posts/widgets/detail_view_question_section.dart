import 'package:designhub/features/posts/models/post.dart';
import 'package:designhub/features/posts/view/new_post_page.dart';
import 'package:designhub/gen/assets.gen.dart';
import 'package:flutter/material.dart';

class DetailViewQuestionSection extends StatelessWidget {
  const DetailViewQuestionSection({super.key, required this.post});
  final Post post;

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
        ...post.questions.map(
          (e) => GestureDetector(
            onTap: () {
              // open bottomsheet with this question
            },
            child: Row(
              children: [
                Expanded(
                  flex: 8,
                  child: Text(
                    e.question,
                    style: TextTheme.of(context)
                        .bodyMedium!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                    child: e.type == QuestionType.open
                        ? Assets.icons.addMessage.svg()
                        : Assets.icons.closed.image()),
              ],
            ),
          ),
        ),
        SizedBox(height: 50),
      ],
    );
  }
}
