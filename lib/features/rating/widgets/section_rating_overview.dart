import 'package:designhub/features/answer/controller/answer_controller.dart';
import 'package:designhub/features/posts/models/post.dart';
import 'package:designhub/features/posts/models/question.dart';
import 'package:designhub/features/profile/models/profile_singleton.dart';
import 'package:designhub/features/rating/widgets/rating_done.dart';
import 'package:designhub/shared/view/custom_bottom_sheet.dart';
import 'package:designhub/theme/designhub_colors.dart';
import 'package:flutter/material.dart';

class SectionRatingOverview extends StatelessWidget {
  final Post post;
  final List<Question> questions;
  final List<String> answers;
  final AnswerController controller;

  SectionRatingOverview(
      {super.key,
      required this.questions,
      required this.answers,
      required this.post,
      AnswerController? controller})
      : controller = controller ?? AnswerController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 50,
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      height: MediaQuery.of(context).size.height * 0.85,
      width: double.infinity,
      child: ListView(
        children: [
          Text(
            "Overview",
            style: TextTheme.of(context)
                .headlineMedium!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 24),
          ...questions.asMap().entries.expand((e) {
            return [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Question ${e.key + 1}",
                      style: TextTheme.of(context)
                          .headlineSmall!
                          .copyWith(fontWeight: FontWeight.bold)),
                  Text(e.value.question),
                  SizedBox(height: 12),
                  Container(
                    padding: EdgeInsets.all(12),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: DesignhubColors.grey300),
                    child: Text(answers[e.key],
                        style: TextTheme.of(context).bodyMedium),
                  ),
                  SizedBox(height: 36),
                ],
              )
            ];
          }),
          SizedBox(height: 28),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                  onPressed: () {
                    for (final item in answers) {
                      controller.addAnswerItem(
                          post.postId,
                          questions[answers.indexOf(item)].question,
                          item,
                          ProfileSingleton().profile!.userId,
                          questions[answers.indexOf(item)].type);
                    }
                    CustomBottomSheet.show(context, RatingDone(post: post), 1);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 60.0),
                    child: Text('Done'),
                  )),
            ],
          )
        ],
      ),
    );
  }
}
