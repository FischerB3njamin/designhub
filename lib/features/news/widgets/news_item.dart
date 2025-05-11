import 'package:designhub/features/news/models/news.dart';
import 'package:designhub/features/news/provider/news_notifier.dart';
import 'package:designhub/features/profile/models/profile.dart';
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

  @override
  Widget build(BuildContext context) {
    final newsNotifier = context.watch<NewsNotifier>();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: GestureDetector(
        onTap: () {
          newsNotifier.markNewsAsReaded(news);
          newsNotifier.handleNavigation(
              context, profile, news.postId, news.type);
        },
        child: Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: news.read
                  ? DesignhubColors.transparent
                  : DesignhubColors.primary.withAlpha(50)),
          child: Row(
            children: [
              AvatarCircle(profile: profile, height: 30, width: 30),
              SizedBox(width: 8),
              Text(
                newsNotifier.buildItemText(profile, news.type),
                style: CustomTextStyles.bodySmall(context),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Text(
                  news.date,
                  style: CustomTextStyles.bodySmall(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
