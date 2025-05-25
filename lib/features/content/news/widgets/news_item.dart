import 'package:designhub/features/content/news/models/news.dart';
import 'package:designhub/features/content/news/provider/news_notifier.dart';
import 'package:designhub/features/socials/profile/models/profile.dart';
import 'package:designhub/shared/widgets/avatar_circle.dart';
import 'package:designhub/theme/custom_text_styles.dart';
import 'package:designhub/theme/designhub_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewsItem extends StatelessWidget {
  final News news;
  final Profile profile;

  const NewsItem({
    super.key,
    required this.news,
    required this.profile,
  });

  String formatNewsTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    if (now.year == timestamp.year &&
        now.month == timestamp.month &&
        now.day == timestamp.day) {
      return "${timestamp.hour.toString().padLeft(2, '0')}:${timestamp.minute.toString().padLeft(2, '0')}";
    } else {
      return "${timestamp.day.toString().padLeft(2, '0')}.${timestamp.month.toString().padLeft(2, '0')}";
    }
  }

  @override
  Widget build(BuildContext context) {
    final newsNotifier = context.watch<NewsNotifier>();
    final formattedDate =
        formatNewsTimestamp(DateTime.tryParse(news.date) ?? DateTime.now());

    return GestureDetector(
      onTap: () {
        newsNotifier.markNewsAsReaded(news);
        newsNotifier.handleNavigation(
          context,
          profile,
          news.postId,
          news.type,
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(36),
          color: news.read
              ? Colors.transparent
              : DesignhubColors.primary.withAlpha(40),
        ),
        child: Row(
          children: [
            AvatarCircle(profile: profile, height: 32, width: 32),
            const SizedBox(width: 12),
            Expanded(child: _NewsText(profile: profile, news: news)),
            const SizedBox(width: 8),
            Text(
              formattedDate,
              style: CustomTextStyles.bodySmall(context).copyWith(
                color: DesignhubColors.grey700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NewsText extends StatelessWidget {
  final News news;
  final Profile profile;

  const _NewsText({required this.news, required this.profile});

  @override
  Widget build(BuildContext context) {
    final newsNotifier = context.watch<NewsNotifier>();

    return Text(
      newsNotifier.buildItemText(profile, news.type),
      style: CustomTextStyles.bodyMedium(context).copyWith(
        fontWeight: FontWeight.w500,
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }
}
