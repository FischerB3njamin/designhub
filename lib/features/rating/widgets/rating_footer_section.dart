import 'package:designhub/gen/assets.gen.dart';
import 'package:designhub/theme/designhub_colors.dart';
import 'package:flutter/material.dart';

class RatingFooterSection extends StatelessWidget {
  final int activeQuestion;
  final int numberOfQuestions;
  final Function callback;

  const RatingFooterSection({
    required this.activeQuestion,
    required this.callback,
    required this.numberOfQuestions,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.15,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(Assets.images.ratingBg.path),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ...List.generate(numberOfQuestions, (int index) => index).map(
            (e) => InkWell(
              onTap: () => callback(e),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: e == activeQuestion
                          ? DesignhubColors.black
                          : DesignhubColors.grey),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
