import 'package:designhub/theme/custom_text_styles.dart';
import 'package:designhub/theme/designhub_colors.dart';
import 'package:flutter/material.dart';

class EmptyPosts extends StatelessWidget {
  const EmptyPosts({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.hourglass_empty, size: 60, color: DesignhubColors.grey500),
          const SizedBox(height: 16),
          Text(
            "No posts available",
            style: CustomTextStyles.titleMediumColorBold(
                context, DesignhubColors.grey700, FontWeight.w600),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
