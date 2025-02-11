import 'package:designhub/features/news/models/news.dart';
import 'package:designhub/features/news/models/news_type.dart';
import 'package:designhub/features/posts/data/post_mock_db.dart';
import 'package:designhub/features/posts/view/post_detail_view.dart';
import 'package:designhub/features/profile/data/profile_mock_db.dart';
import 'package:designhub/features/profile/models/profile.dart';
import 'package:designhub/features/profile/view/profile_page.dart';
import 'package:designhub/shared/view/custom_bottom_sheet.dart';
import 'package:designhub/theme/designhub_colors.dart';
import 'package:flutter/material.dart';

class NewsItem extends StatelessWidget {
  final News news;
  final Function callback;
  const NewsItem({
    super.key,
    required this.news,
    required this.callback,
  });

  String buildItemText(Profile profile) {
    switch (news.type) {
      case NewsType.comment:
        return "${profile.name} left a comment on your work!";

      case NewsType.feedback:
        return "${profile.name} gave you feedback!";

      case NewsType.follow:
        return "${profile.name} following your work now!";
    }
  }

  void handleNewsClick(BuildContext context, Profile profile) {
    callback(news);
    handleNavigation(context, profile);
  }

  void handleNavigation(BuildContext context, Profile profile) =>
      CustomBottomSheet.show(
          context,
          NewsType.follow == news.type
              ? ProfilePage(profile: profile)
              : PostDetailView(
                  post: PostMockDB().getPostById(news.postId!),
                ),
          0.9);

  @override
  Widget build(BuildContext context) {
    ProfileMockDB db = ProfileMockDB();
    Profile profile = db.getProfile(news.profilId);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: GestureDetector(
        onTap: () => handleNewsClick(context, profile),
        child: Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: news.read
                  ? DesignhubColors.transparent
                  : DesignhubColors.primary.withAlpha(50)),
          child: Row(
            children: [
              Container(
                height: 30,
                width: 30,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(shape: BoxShape.circle),
                child:
                    Image.network(profile.avatarImagePath, fit: BoxFit.cover),
              ),
              SizedBox(width: 8),
              Text(
                buildItemText(profile),
                style: TextTheme.of(context).bodySmall,
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Text(
                  news.date,
                  style: TextTheme.of(context).bodySmall,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
